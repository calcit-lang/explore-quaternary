
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |respo.calcit/ |respo-ui.calcit/ |reel.calcit/
      :type-slots $ {} $ :dispatch-op 'app.schema/Op
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-branch $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-branch (states v on-change)
            let
                cursor $ decode-map-as
                  .unwrap $ &map:get states :cursor
                  List respo.schema/CoordKey
                leaf $ match v
                  (:some value)
                    match value
                      (Bool flag) (Some flag)
                      (Tag _) None
                  (:none) None
                expanded? $ and (.some? v) (.none? leaf)
              div
                {} $ :style $ {}
                div
                  {} (:class-name |controller)
                    :style $ {} (:text-align |center) (:line-height |10px) (:font-size |12px) (:cursor |pointer)
                    :on-click $ fn (e d!)
                      hint-fn $ Fn respo.schema/RespoEvent
                        Fn Op $ -> Unit
                        -> Unit
                      if expanded?
                        do (on-change false d!)
                          d! $ Op :clear-states cursor
                        on-change :branch d!
                      , &unit
                  <> $ if expanded? |x |Br
                match leaf
                  (:some flag)
                    comp-leaf flag $ fn (next d!) (on-change next d!)
                  (:none) (comp-quaternary states)
          :examples $ []
          :schema $ quote $ Fn respo.schema/States (Option app.schema/BranchValue)
            Fn app.schema/BranchValue
              Fn Op $ -> Unit
              -> Unit
            -> respo.schema/Component
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (reel on-control)
            let
                store $ :store reel
                states $ as-states-map $ .unwrap-or (get store :states) ({})
                cursor $ decode-map-as
                  match (&map:get states :cursor)
                    (:some value)
                      either value $ []
                    (:none) ([])
                  List respo.schema/CoordKey
                state $ decode-map-as
                  match (&map:get states :data)
                    (:some value)
                      either value $ {} (:content |) (:size 1)
                    (:none)
                      {} (:content |) (:size 1)
                  Map Tag Dynamic
                size $ decode-map-as
                  match (get state :size)
                    (:some value) (either value 1)
                    (:none) 1
                  , 'Number
              div
                {} $ :style $ .merge ui/global ui/column
                div ({})
                  span $ {} (:style style-button) (:inner-text |Less)
                    :on-click $ fn (e d!)
                      hint-fn $ Fn respo.schema/RespoEvent
                        Fn Op $ -> Unit
                        -> Unit
                      when (> size 1)
                        d! $ Op :resize cursor $ dec size
                      , &unit
                  span $ {} (:style style-button) (:inner-text |More)
                    :on-click $ fn (e d!)
                      hint-fn $ Fn respo.schema/RespoEvent
                        Fn Op $ -> Unit
                        -> Unit
                      d! $ Op :resize cursor $ inc size
                      , &unit
                list->
                  {} $ :style $ .merge ui/row
                    {} $ :flex-wrap |wrap
                  -> size range $ map $ fn (idx)
                    [] idx $ div
                      {} $ :style $ {} (:margin |8px) (:padding |8px)
                        :border $ str "|1px solid " $ hsl 0 0 90
                      div
                        {} $ :style $ {} (:text-align |center) (:line-height |16px)
                        <> $ str idx
                      comp-quaternary $ >> states idx
                if dev?
                  Some $ comp-typed-reel (>> states :reel) reel ({}) on-control
                  , None
                if dev?
                  Some $ comp-inspect |reel states $ {} (:bottom |0px)
                  , None
          :examples $ []
          :schema $ quote $ Fn
            reel.typed/State Op $ Map Tag V
            Fn reel.typed/Control $ -> Unit
            -> respo.schema/Component
            :generics V
            :features :state
        'comp-leaf $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-leaf (v? on-change)
            div $ {}
              :style $ {} (:width |16px) (:height |16px) (:cursor |pointer)
                :background-color $ if v? (hsl 200 80 50) (hsl 0 0 80)
              :on-click $ fn (e d!)
                hint-fn $ Fn respo.schema/RespoEvent
                  Fn Op $ -> Unit
                  -> Unit
                on-change (not v?) d!
          :examples $ []
          :schema $ quote $ Fn Bool
            Fn Bool
              Fn Op $ -> Unit
              -> Unit
            -> respo.schema/Component
        'comp-quaternary $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-quaternary (states)
            let
                cursor $ decode-map-as
                  .unwrap $ &map:get states :cursor
                  List respo.schema/CoordKey
                state $ read-branch-view $ decode-map-as
                  match (&map:get states :data)
                    (:some value)
                      either value $ {} (:left? false) (:right? false) (:a false) (:b false)
                    (:none)
                      {} (:left? false) (:right? false) (:a false) (:b false)
                  Map Tag Dynamic
              div
                {} $ :style $ .merge ui/row
                  {} $ :display |inline-flex
                div
                  {} $ :style $ {} (:padding-top |11px)
                  comp-leaf (:left? state)
                    fn (v d!)
                      d! $ Op :edit-branch cursor $ app.schema/BranchEdit :left v
                      , &unit
                space-x 2
                comp-branch (>> states :a) (:a state)
                  fn (v d!)
                    d! $ Op :edit-branch cursor $ app.schema/BranchEdit :a v
                    , &unit
                space-x 2
                comp-branch (>> states :b) (:b state)
                  fn (v d!)
                    d! $ Op :edit-branch cursor $ app.schema/BranchEdit :b v
                    , &unit
                div
                  {} $ :style $ {} (:padding-top |11px)
                  comp-leaf (:right? state)
                    fn (v d!)
                      d! $ Op :edit-branch cursor $ app.schema/BranchEdit :right v
                      , &unit
          :examples $ []
          :schema $ quote $ Fn respo.schema/States (-> respo.schema/Component)
        'read-branch $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn read-branch (state field)
            match (get state field)
              (:some raw)
                if (nil? raw) None $ Some $ decode-map-as raw 'app.schema/BranchValue
              (:none) None
          :examples $ []
          :schema $ quote $ Fn (Map Tag V) Tag
            -> $ Option app.schema/BranchValue
            :generics V
        'read-branch-view $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn read-branch-view (state)
            app.schema/BranchView :left?
              decode-map-as
                .unwrap $ get state :left?
                , 'Bool
              , :right?
                decode-map-as
                  .unwrap $ get state :right?
                  , 'Bool
                , :a (read-branch state :a) :b $ read-branch state :b
          :examples $ []
          :schema $ quote $ Fn (Map Tag V) (-> app.schema/BranchView) (:generics V)
        'style-button $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def style-button
            {} (:margin "|0 6px") (:cursor |pointer) (:font-family ui/font-fancy)
          :examples $ []
          :schema $ quote $ Map Tag String
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require (respo-ui.core :as ui)
            respo.util.format :refer $ hsl
            respo.core :refer $ defcomp <> >> div span list-> as-states-map
            respo.comp.space :refer $ space-x
            respo.comp.inspect :refer $ comp-inspect
            reel.comp.reel :refer $ comp-typed-reel
            app.config :refer $ dev?
            app.schema :refer $ Op
    'app.config $ %{} 'FileEntry
      :defs $ {}
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ .unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ quote Bool
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} $ :storage-key |workflow
          :examples $ []
          :schema $ quote $ Map Tag String
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*reel $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *reel (typed/new-reel schema/store)
          :examples $ []
          :schema $ quote $ Ref
            typed/State schema/Op $ Map Tag Dynamic
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            when config/dev? $ println |Dispatch: op
            reset! *reel $ match op
              (reel.typed/Control control) (typed/apply-control updater @*reel control)
              (app.schema/Op action)
                typed/record-op updater @*reel action (generate-id!)
                  :timestamp $ date-now-snapshot
            , &unit
          :examples $ []
          :schema $ quote $ Fn schema/ResolvedOp (-> Unit) (:features :io :js-ffi :state)
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! ()
            println "|Running mode:" $ if config/dev? |dev |release
            if config/dev? $ load-console-formatter!
            let
                raw $ browser/storage-get $ .unwrap (get config/site :storage-key)
              when (.some? raw)
                dispatch! $ schema/Op :hydrate-storage $ decode-map-as
                  parse-cirru-edn $ .unwrap raw
                  Map Tag Dynamic
            render-app!
            add-watch! *reel :changes $ fn (reel prev) (render-app!)
            listen-devtools! |k on-reel-control!
            browser/add-event-listener! |beforeunload $ fn (event) (persist-storage!)
            repeat! 60 persist-storage!
            println "|App started."
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def mount-target
            narrow-element $ .unwrap $ browser/query-selector |.app
          :examples $ []
          :schema $ quote respo.dom/DomElement
        'on-reel-control! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn on-reel-control! (control) (dispatch! control)
          :examples $ []
          :schema $ quote $ Fn typed/Control (-> Unit) (:features :io :js-ffi :state)
        'persist-storage! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn persist-storage! ()
            browser/storage-set!
              .unwrap $ get config/site :storage-key
              format-cirru-edn $ :store @*reel
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :js-ffi :state)
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do (remove-watch! *reel :changes) (clear-cache!)
                add-watch! *reel :changes $ fn (reel prev) (render-app!)
                reset! *reel $ typed/refresh updater @*reel schema/store
                hud! |ok~ |Ok
              hud! |error build-errors
            , &unit
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :state)
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render-with! mount-target
              fn ()
                hint-fn $ Fn $ -> respo.schema/Component
                comp-container @*reel on-reel-control!
              fn (op)
                hint-fn $ Fn schema/Op $ -> Unit
                dispatch! op
          :examples $ []
          :schema $ quote $ Fn (-> Unit) (:features :io :js-ffi :state)
        'repeat! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn repeat! (duration cb)
            browser/set-timeout!
              fn () (cb) (repeat! duration cb)
              * 1000 duration
            , &unit
          :examples $ []
          :schema $ quote $ Fn Number
            Fn $ -> Unit
            -> Unit
            :features :js-ffi
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            respo.core :refer $ render-with! clear-cache!
            app.comp.container :refer $ comp-container
            app.updater :refer $ updater
            app.schema :as schema
            reel.util :refer $ listen-devtools!
            reel.typed :as typed
            app.config :as config
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
            js-ffi.browser :as browser
            js-ffi.shared :refer $ date-now-snapshot
            respo.ffi.browser :refer $ narrow-element
    'app.schema $ %{} 'FileEntry
      :defs $ {}
        'BranchEdit $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum BranchEdit (:left Bool) (:right Bool) (:a app.schema/BranchValue) (:b app.schema/BranchValue)
          :examples $ []
          :schema $ quote EnumDef
        'BranchValue $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion BranchValue Bool Tag
          :examples $ []
          :schema $ quote UnionDef
        'BranchView $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defstruct BranchView (:left? Bool) (:right? Bool)
            :a $ Option app.schema/BranchValue
            :b $ Option app.schema/BranchValue
          :examples $ []
          :schema $ quote StructDef
        'Op $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defenum Op
            :resize (List respo.schema/CoordKey) Number
            :edit-branch (List respo.schema/CoordKey) app.schema/BranchEdit
            :clear-states $ List respo.schema/CoordKey
            :hydrate-storage $ Map Tag Dynamic
          :examples $ []
          :schema $ quote EnumDef
        'ResolvedOp $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defunion ResolvedOp Op reel.typed/Control
          :examples $ []
          :schema $ quote UnionDef
        'store $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            {} $ :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ quote $ Map Tag
            Map Tag $ List respo.schema/CoordKey
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
    'app.updater $ %{} 'FileEntry
      :defs $ {}
        'clear-states $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn clear-states (store cursor)
            decode-map-as
              dissoc-in store $ prepend cursor :states
              Map Tag Dynamic
          :examples $ []
          :schema $ quote $ Fn (Map Tag StoreValue) (List respo.schema/CoordKey)
            -> $ Map Tag Dynamic
            :generics StoreValue
        'read-state-data $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn read-state-data (store cursor fallback)
            match
              get-in store $ conj (prepend cursor :states) :data
              (:ok raw)
                if (nil? raw) fallback $ decode-map-as raw $ Map Tag Dynamic
              (:err _) fallback
          :examples $ []
          :schema $ quote $ Fn (Map Tag StoreValue) (List respo.schema/CoordKey) (Map Tag FallbackValue)
            -> $ Map Tag Dynamic
            :generics StoreValue FallbackValue
        'updater $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-id op-time)
            match op
              (:resize cursor size)
                let
                    state $ read-state-data store cursor $ {} (:content |) (:size 1)
                  decode-map-as
                    update-states store cursor $ assoc state :size size
                    Map Tag Dynamic
              (:edit-branch cursor edit)
                let
                    state $ read-state-data store cursor $ {} (:left? false) (:right? false) (:a false) (:b false)
                    next $ match edit
                      (:left flag) (assoc state :left? flag)
                      (:right flag) (assoc state :right? flag)
                      (:a value) (assoc state :a value)
                      (:b value) (assoc state :b value)
                  decode-map-as (update-states store cursor next) (Map Tag Dynamic)
              (:clear-states cursor) (clear-states store cursor)
              (:hydrate-storage data) data
          :examples $ []
          :schema $ quote $ Fn (Map Tag StoreValue) Op String Number
            -> $ Map Tag Dynamic
            :generics StoreValue
          :tests $ []
            %{} 'TestEntry (:name |hydrates-stored-state)
              :code $ quote $ is=
                {} $ :counter 2
                updater
                  {} $ :counter 1
                  Op :hydrate-storage $ {} $ :counter 2
                  , |test 0
              :tags $ #{} :storage :unit
            %{} 'TestEntry (:name |typed-edits-preserve-other-fields)
              :code $ quote $ let
                  cursor $ [] 0 :child
                  original $ updater app.schema/store
                    Op :resize ([]) 2
                    , |resize 0
                  seeded $ decode-map-as
                    update-states original cursor $ {} (:left? false) (:right? false) (:a false) (:b false) (:legacy |keep)
                    Map Tag Dynamic
                  opened $ updater seeded
                    Op :edit-branch cursor $ app.schema/BranchEdit :a :branch
                    , |open 2
                  toggled $ updater opened
                    Op :edit-branch cursor $ app.schema/BranchEdit :left true
                    , |toggle 3
                assert= (Result :ok 2)
                  get-in toggled $ [] :states :data :size
                assert= (Result :ok :branch)
                  get-in toggled $ [] :states 0 :child :data :a
                assert= (Result :ok true)
                  get-in toggled $ [] :states 0 :child :data :left?
                assert= (Result :ok |keep)
                  get-in toggled $ [] :states 0 :child :data :legacy
              :tags $ #{} :unit
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require
            respo.cursor :refer $ update-states
            calcit.test :refer $ is=
            app.schema :refer $ Op
