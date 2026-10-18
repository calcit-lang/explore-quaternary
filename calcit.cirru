
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :js) (:reload-fn 'app.main/reload!) (:target :browser)
      :feature-policy $ {}
      :modules $ [] |respo.calcit/ |respo-ui.calcit/ |reel.calcit/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-branch $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-branch (states v on-change)
            let
                cursor $ decode-map-as (read-field states :cursor) (:: 'List 'Dynamic)
              div
                {} $ :style $ {}
                div
                  {} (:class-name |controller)
                    :style $ {} (:text-align |center) (:line-height |10px) (:font-size 12) (:cursor |pointer)
                    :on-click $ fn (e d!)
                      hint-fn $ {} (:return 'Unit)
                        :args $ [] (:: 'Map 'Tag 'Dynamic)
                          :: 'Fn $ {} (:return 'Unit) (:rest 'Dynamic)
                            :args $ [] 'Dynamic
                      if (tag? v)
                        do (on-change false d!)
                          d! $ :: :clear-states cursor
                        on-change :branch d!
                      , &unit
                  <> $ if (tag? v) |x |Br
                if (bool? v)
                  comp-leaf v $ fn (next d!) (on-change next d!)
                  comp-quaternary states
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'respo.schema/Component)
            :args $ [] (:: 'Map 'Dynamic 'Dynamic) 'Dynamic $ :: 'Fn
              {} (:return 'Unit)
                :args $ [] 'Dynamic $ :: 'Fn
                  {} (:return 'Unit)
                    :args $ [] 'Enum
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (reel)
            let
                store $ :store reel
                states $ as-states-map $ read-field store :states
                cursor $ decode-map-as
                  either (read-field states :cursor) ([])
                  :: 'List 'Dynamic
                state $ decode-map-as
                  either (read-field states :data)
                    {} (:content |) (:size 1)
                  :: 'Map 'Tag 'Dynamic
                size $ decode-map-as
                  either (read-field state :size) 1
                  , 'Number
              div
                {} $ :style $ merge ui/global ui/column
                div ({})
                  span $ {} (:style style-button) (:inner-text |Less)
                    :on-click $ fn (e d!)
                      when (> size 1)
                        d! $ :: :states cursor $ update state :size
                          fn (value)
                            dec $ decode-map-as value 'Number
                      , &unit
                  span $ {} (:style style-button) (:inner-text |More)
                    :on-click $ fn (e d!)
                      d! $ :: :states cursor $ update state :size
                        fn (value)
                          inc $ decode-map-as value 'Number
                      , &unit
                list->
                  {} $ :style $ merge ui/row
                    {} $ :flex-wrap |wrap
                  -> size range $ map $ fn (idx)
                    [] idx $ div
                      {} $ :style $ {} (:margin |8px) (:padding 8)
                        :border $ str "|1px solid " $ hsl 0 0 90
                      div
                        {} $ :style $ {} (:text-align |center) (:line-height |16px)
                        <> $ str idx
                      comp-quaternary $ >> states idx
                when dev? $ comp-typed-reel (>> states :reel) reel $ {}
                when dev? $ comp-inspect |reel states $ {} (:bottom 0)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'respo.schema/Component)
            :args $ [] $ :: 'reel.typed/State 'Enum (:: 'Map 'Tag 'Dynamic)
        'comp-leaf $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-leaf (v? on-change)
            div $ {}
              :style $ {} (:width 16) (:height 16) (:cursor :pointer)
                :background-color $ if v? (hsl 200 80 50) (hsl 0 0 80)
              :on-click $ fn (e d!)
                hint-fn $ {} (:return 'Unit)
                  :args $ [] (:: 'Map 'Tag 'Dynamic)
                    :: 'Fn $ {} (:return 'Unit) (:rest 'Dynamic)
                      :args $ [] 'Dynamic
                on-change (not v?) d!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'respo.schema/Component)
            :args $ [] 'Bool $ :: 'Fn
              {} (:return 'Unit)
                :args $ [] 'Bool $ :: 'Fn
                  {} (:return 'Unit)
                    :args $ [] 'Enum
        'comp-quaternary $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-quaternary (states)
            let
                cursor $ decode-map-as (read-field states :cursor) (:: 'List 'Dynamic)
                state $ decode-map-as
                  either (read-field states :data)
                    {} (:left? false) (:right? false) (:a false) (:b false)
                  :: 'Map 'Tag 'Dynamic
              div
                {} $ :style $ merge ui/row
                  {} $ :display |inline-flex
                div
                  {} $ :style $ {} (:padding-top |11px)
                  comp-leaf
                    decode-map-as (read-field state :left?) 'Bool
                    fn (v d!)
                      d! $ :: :states cursor $ assoc state :left? v
                      , &unit
                =< 2 nil
                comp-branch (>> states :a) (read-field state :a)
                  fn (v d!)
                    d! $ :: :states cursor $ assoc state :a v
                    , &unit
                =< 2 nil
                comp-branch (>> states :b) (read-field state :b)
                  fn (v d!)
                    d! $ :: :states cursor $ assoc state :b v
                    , &unit
                div
                  {} $ :style $ {} (:padding-top |11px)
                  comp-leaf
                    decode-map-as (read-field state :right?) 'Bool
                    fn (v d!)
                      d! $ :: :states cursor $ assoc state :right? v
                      , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'respo.schema/Component)
            :args $ [] $ :: 'Map 'Dynamic 'Dynamic
        'style-button $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def style-button
            {} (:margin "|0 6px") (:cursor :pointer) (:font-family ui/font-fancy)
          :examples $ []
          :schema $ :: 'Map 'Tag 'String
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require (respo-ui.core :as ui)
            respo.util.format :refer $ hsl
            respo.core :refer $ defcomp <> >> div span list-> as-states-map
            respo.comp.space :refer $ =<
            respo.comp.inspect :refer $ comp-inspect
            reel.comp.reel :refer $ comp-typed-reel
            app.config :refer $ dev?
            reel.schema :refer $ read-field
    'app.config $ %{} 'FileEntry
      :defs $ {}
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ option:unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ :: 'Bool
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} $ :storage-key |workflow
          :examples $ []
          :schema $ :: 'Map 'Tag 'String
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*reel $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defref *reel (typed/new-reel schema/store)
          :examples $ []
          :schema $ :: 'Ref $ :: 'reel.typed/State 'Enum (:: 'Map 'Tag 'Dynamic)
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            when config/dev? $ println |Dispatch: op
            let
                checked $ if (enum? op) op $ raise |Expected-Enum-operation
              match (typed/decode-control checked)
                (:some control)
                  reset! *reel $ typed/apply-control updater @*reel control
                (:none)
                  reset! *reel $ typed/record-op updater @*reel checked (generate-id!)
                    :timestamp $ date-now-snapshot
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Dynamic
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! ()
            println "|Running mode:" $ if config/dev? |dev |release
            if config/dev? $ load-console-formatter!
            render-app!
            add-watch! *reel :changes $ fn (reel prev) (render-app!)
            listen-devtools! |k dispatch!
            browser/add-event-listener! |beforeunload $ fn (event) (persist-storage!)
            repeat! 60 persist-storage!
            let
                raw $ browser/storage-get $ option:unwrap (get config/site :storage-key)
              when (option:some? raw)
                dispatch! $ :: :hydrate-storage $ parse-cirru-edn (option:unwrap raw)
            println "|App started."
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def mount-target
            narrow-element $ option:unwrap $ browser/query-selector |.app
          :examples $ []
          :schema $ :: 'respo.dom/DomElement
        'persist-storage! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn persist-storage! ()
            browser/storage-set!
              option:unwrap $ get config/site :storage-key
              format-cirru-edn $ :store @*reel
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
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
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render! mount-target (comp-container @*reel) dispatch!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'repeat! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn repeat! (duration cb)
            browser/set-timeout!
              fn () (cb) (repeat! duration cb)
              * 1000 duration
            , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Number $ :: 'Fn
              {} (:return 'Unit)
                :args $ []
            :features $ #{} :js-ffi
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.main
          :require
            respo.core :refer $ render! clear-cache!
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
      :defs $ {} $ 'store
        %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            {} $ :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ :: 'Map 'Tag 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
    'app.updater $ %{} 'FileEntry
      :defs $ {}
        'clear-states $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn clear-states (store cursor)
            decode-map-as
              dissoc-in store $ prepend cursor :states
              :: 'Map 'Tag 'Dynamic
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'Map 'Tag 'Dynamic) (:: 'List 'Dynamic)
            :return $ :: 'Map 'Tag 'Dynamic
        'updater $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-id op-time)
            match op
              (:states cursor s)
                decode-map-as
                  update-states store
                    decode-map-as cursor $ :: 'List 'Dynamic
                    , s
                  :: 'Map 'Tag 'Dynamic
              (:clear-states cursor)
                clear-states store $ decode-map-as cursor $ :: 'List 'Dynamic
              (:hydrate-storage data)
                decode-map-as data $ :: 'Map 'Tag 'Dynamic
              _ $ do (eprintln "|Unknown op:" op) store
          :examples $ []
          :schema $ :: 'Fn $ {}
            :args $ [] (:: 'Map 'Tag 'Dynamic) 'Enum 'String 'Number
            :return $ :: 'Map 'Tag 'Dynamic
          :tests $ [] $ %{} 'TestEntry (:name |hydrates-stored-state)
            :code $ quote $ is=
              {} $ :counter 2
              updater
                {} $ :counter 1
                :: :hydrate-storage $ {} $ :counter 2
                , |test 0
            :tags $ #{} :storage :unit
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require
            respo.cursor :refer $ update-states
            calcit.test :refer $ is=
