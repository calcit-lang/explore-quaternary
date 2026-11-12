import assert from "node:assert/strict";
import { test } from "node:test";
import * as calcit from "../js-out/calcit.core.mjs";
import { comp_quaternary } from "../js-out/app.comp.container.mjs";
import { updater } from "../js-out/app.updater.mjs";

const map = calcit._$n__$M_;
const tag = calcit.newTag;
const get = (value, key) => calcit.option_$o_unwrap(calcit.get(value, tag(key)));

function leaves(tree, componentName) {
  const [node] = tree.extra;
  if (!node) return [];
  const [value] = node.extra;
  if (node.tag.toString() === ":component") {
    return leaves(get(value, "tree"), get(value, "name").toString());
  }
  if (componentName === ":comp-leaf") return [value];
  return get(value, "children").toArray().flatMap(child => leaves(get(child, "node")));
}

test("restored nested leaf renders its saved value and dispatches its own cursor", () => {
  const state = (left, a) => map(tag("left?"), left, tag("right?"), false, tag("a"), a, tag("b"), false);
  const saved = map(tag("states"), map(tag("tree"), map(
    tag("data"), state(false, tag("branch")),
    tag("a"), map(tag("data"), state(true, false)),
  )));
  const restored = calcit.parse_cirru_edn(calcit.format_cirru_edn(saved));
  const branch = store => get(get(store, "states"), "tree");
  const states = calcit.assoc(branch(restored), tag("cursor"), calcit._$L_(tag("tree")));
  const active = leaves(get(comp_quaternary(states), "tree")).filter(
    leaf => get(leaf, "style").toString().includes("hsl(200,80%,50%,1)"),
  );
  assert.equal(active.length, 1);

  const actions = [];
  get(get(active[0], "event"), "click")(null, op => actions.push(op));
  assert.equal(actions.length, 1);
  const [action] = actions;
  assert.equal(action.tag.toString(), ":edit-branch");
  assert.deepEqual(action.extra[0].toArray().map(String), [":tree", ":a"]);
  assert.equal(action.extra[1].tag.toString(), ":left");
  assert.equal(action.extra[1].extra[0], false);

  const next = updater(restored, action, "fixture", 0);
  assert.equal(get(get(get(branch(next), "a"), "data"), "left?"), false);
  assert.equal(get(get(branch(next), "data"), "a").toString(), ":branch");
});
