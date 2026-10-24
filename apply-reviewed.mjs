import assert from 'node:assert/strict';
import {execFileSync} from 'node:child_process';
import {readFileSync,writeFileSync,mkdirSync} from 'node:fs';
assert.equal(process.env.GITHUB_ACTIONS,'true');assert.equal(process.platform,'linux');
assert.equal(execFileSync('calcit',['-v'],{encoding:'utf8'}).trim(),'0.30.1');
const run=(...a)=>execFileSync('calcit',['calcit.cirru',...a],{encoding:'utf8',maxBuffer:48e6,stdio:['ignore','pipe','pipe']});
const blob=()=>execFileSync('git',['hash-object','calcit.cirru'],{encoding:'utf8'}).trim();
assert.equal(blob(),'2d862565b988a58ec77b627c1579b3d8f81dd31d');
const norm=v=>Array.isArray(v)?v.map(norm):v&&typeof v==='object'?Object.fromEntries(Object.entries(v).map(([k,x])=>[k,k==='__edn_set'?x.map(norm).sort((a,b)=>JSON.stringify(a).localeCompare(JSON.stringify(b))):norm(x)])):v;
const q=(...a)=>norm(JSON.parse(run('query',...a,'--format','json')).data);
const input=JSON.parse(readFileSync('reviewed.json','utf8'));
const before={config:norm(input.config.data),namespaces:input.namespaces.map(x=>norm(x.data)),defs:input.definitions.map(x=>norm(x.data))};
assert.equal(before.defs.length,20);assert.equal(before.defs.reduce((n,d)=>n+d.tests.length,0),1);assert.equal(before.defs.reduce((n,d)=>n+d.examples.length,0),0);
assert.deepEqual(q('config'),before.config);assert.deepEqual(q('ns').namespaces.map(n=>q('ns',n)),before.namespaces);
for(const d of before.defs)assert.deepEqual(q('def',d.id),d);
const expected=structuredClone(before),ops=[],sites=[],counts={merge:0,'option:unwrap-or':0,'option:unwrap':0,'option:some?':0,css:0,domContract:0};
const show=(id,path)=>JSON.parse(run('tree','show',id,'--path','@'+path.join('.'),'--format','json')).tree;
const replace=(id,path,value)=>ops.push(['tree','replace',id,'--path','@'+path.join('.'),'--input-format','json-ast','--code',JSON.stringify(value)]);
const hint=['hint-fn',['{}',[':return',"'Unit"],[':args',['[]',['::',"'Map","'Tag","'Dynamic"],['::',"'Fn",['{}',[':return',"'Unit"],[':rest',"'Dynamic"],[':args',['[]',"'Dynamic"]]]]]]]];
const cssKeys=new Set([':font-size',':padding',':width',':height',':cursor',':bottom']);
function walk(x,path,id){
  if(!Array.isArray(x)||['quote','quasiquote','comment',';','defmacro'].includes(x[0]))return x;
  const original=structuredClone(x);
  if(['merge','option:unwrap-or','option:unwrap','option:some?'].includes(x[0])){
    const old=x[0];assert.deepEqual(show(id,path),original);const next={merge:'.merge','option:unwrap-or':'.unwrap-or','option:unwrap':'.unwrap','option:some?':'.some?'}[old];replace(id,[...path,0],next);x[0]=next;counts[old]++;sites.push({id,path,original});
  }
  if(x[0]==='{}')for(let j=1;j<x.length;j++){
    const pair=x[j];if(!Array.isArray(pair)||pair.length!==2||!cssKeys.has(pair[0]))continue;
    const [k,v]=pair;let next;
    if(/^\d+$/.test(v))next='|'+v+'px';else if(v===':pointer')next='|pointer';
    if(next!==undefined){assert.ok(id.startsWith('app.comp.container/'));const p=[...path,j,1];assert.equal(show(id,p),v);replace(id,p,next);pair[1]=next;counts.css++;sites.push({id,path:p,before:v,after:next,property:k});}
  }
  if(id==='app.comp.container/comp-container'&&x[0]==='fn'&&JSON.stringify(x[1])===JSON.stringify(['e','d!'])){
    assert.deepEqual(show(id,path),original);assert.notEqual(x[2]?.[0],'hint-fn');assert.equal(x.at(-1),'&unit');
    const p=[...path,2];assert.deepEqual(show(id,p),original[2]);ops.push(['tree','insert',id,'--path','@'+p.join('.'),'--at','before','--input-format','json-ast','--code',JSON.stringify(hint)]);x.splice(2,0,structuredClone(hint));counts.domContract++;sites.push({id,path:p,inserted:hint});
  }
  return x.map((v,i)=>walk(v,[...path,i],id));
}
for(const d of expected.defs)d.code=walk(d.code,[],d.id);
assert.deepEqual(counts,{merge:3,'option:unwrap-or':1,'option:unwrap':4,'option:some?':1,css:7,domContract:2});assert.equal(ops.length,18);
for(let i=0;i<before.defs.length;i++)assert.deepEqual(expected.defs[i].schema,before.defs[i].schema);
for(const id of ['app.main/reload!','app.main/dispatch!','app.main/repeat!','app.main/render-app!','app.updater/updater','app.updater/clear-states','app.schema/store'])assert.deepEqual(expected.defs.find(d=>d.id===id),before.defs.find(d=>d.id===id));
mkdirSync('acceptance',{recursive:true});
for(const [name,value]of Object.entries({before,expected,sites,operations:ops}))writeFileSync('acceptance/'+name+'.json',JSON.stringify(value,null,2));
const args=['edit','transaction','--file','acceptance/operations.json','--format','json'];
const preview=JSON.parse(run(...args,'--dry-run'));assert.ok(preview.scoped_revision);
writeFileSync('acceptance/preview.json',JSON.stringify(preview,null,2));writeFileSync('acceptance/applied.json',run(...args,'--expect-revision',preview.scoped_revision));
const after={config:q('config'),namespaces:q('ns').namespaces.map(n=>q('ns',n)),defs:expected.defs.map(d=>q('def',d.id))};assert.deepEqual(after,expected);
writeFileSync('acceptance/after.json',JSON.stringify(after,null,2));writeFileSync('acceptance/snapshot-after-blob.txt',blob());
writeFileSync('acceptance/summary.json',JSON.stringify({definitions:20,tests:1,examples:0,operations:18,counts,unsafeBefore:0,unsafeAfter:0,preserved:'Allpublicschemas/metadata/ns/config/attachedtest; mixedTagNumberStringstatekeys andunknownarchivefields kept,notfakeTagonlyMap;Bool/Tagbranchwire,cursor,updateMissingSize,clearStates,restorebeforepersistence,HDUactualreloaddefinition and60srepeat preserved. TwoDOMhints exactpublishedEventHandler,eventMapTagDynamic/FnDynamicUnitrestDynamic,noextrahelper/cast/budget/framework/compilerproof.'},null,2));
