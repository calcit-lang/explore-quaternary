
{}
  :about "|Machine-generated snapshot. Do not edit directly — changes will be overwritten. Use `calcit query` to inspect and `calcit edit`/`calcit tree` to modify. Run `calcit docs agents --contract` before mutations; use `--full` for first orientation or changed contract digest. Manual edits must follow format and schema conventions, then run `calcit edit format`."
  :package |app
  :entries $ {} $ :default
    {} (:description |) (:init-fn 'app.main/main!) (:mode :native) (:reload-fn 'app.main/reload!)
      :feature-policy $ {}
      :modules $ [] |respo.calcit/ |lilac/ |memof/ |respo-ui.calcit/ |respo-markdown.calcit/ |reel.calcit/
      :type-slots $ {}
  :files $ {}
    'app.comp.container $ %{} 'FileEntry
      :defs $ {}
        'comp-branch $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-branch (states v on-change)
            let
                cursor $ read-field states :cursor
              div
                {} $ :style $ {}
                div
                  {} (:class-name |controller)
                    :style $ {} (:text-align |center) (:line-height |10px) (:font-size 12) (:cursor |pointer)
                    :on-click $ fn (e d!)
                      if (tag? v)
                        do (on-change false d!)
                          d! $ :: :clear-states cursor
                        on-change :branch d!
                  <> $ if (tag? v) |x |Br
                if (bool? v)
                  comp-leaf v $ fn (next d!) (on-change next d!)
                  comp-quaternary states
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] 'Dynamic 'Dynamic 'Dynamic
            :features $ #{} :js-ffi
        'comp-container $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-container (reel)
            let
                store $ read-field reel :store
                states $ read-field store :states
                cursor $ either (read-field states :cursor) ([])
                state $ either (read-field states :data)
                  {} (:content |) (:size 1)
                size $ either (read-field state :size) 1
              div
                {} $ :style $ merge ui/global ui/column
                div ({})
                  span $ {} (:style style-button) (:inner-text |Less)
                    :on-click $ fn (e d!)
                      if (> size 1)
                        d! cursor $ update state :size dec
                        , nil
                  span $ {} (:style style-button) (:inner-text |More)
                    :on-click $ fn (e d!)
                      d! cursor $ update state :size inc
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
                when dev? $ comp-reel (>> states :reel) reel $ {}
                when dev? $ comp-inspect |reel states $ {} (:bottom 0)
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'respo.schema/Component)
            :args $ [] 'Dynamic
            :features $ #{} :js-ffi
        'comp-leaf $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-leaf (v? on-change)
            div $ {}
              :style $ {} (:width 16) (:height 16) (:cursor :pointer)
                :background-color $ if v? (hsl 200 80 50) (hsl 0 0 80)
              :on-click $ fn (e d!)
                on-change (not v?) d!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] 'Dynamic 'Dynamic
            :features $ #{} :js-ffi
        'comp-quaternary $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defcomp comp-quaternary (states)
            let
                cursor $ read-field states :cursor
                state $ either (read-field states :data)
                  {} (:left? false) (:right? false) (:a false) (:b false)
              div
                {} $ :style $ merge ui/row
                  {} $ :display |inline-flex
                div
                  {} $ :style $ {} (:padding-top |11px)
                  comp-leaf (read-field state :left?)
                    fn (v d!)
                      d! cursor $ assoc state :left? v
                =< 2 nil
                comp-branch (>> states :a) (read-field state :a)
                  fn (v d!)
                    d! cursor $ assoc state :a v
                =< 2 nil
                comp-branch (>> states :b) (read-field state :b)
                  fn (v d!)
                    d! cursor $ assoc state :b v
                =< 2 nil
                div
                  {} $ :style $ {} (:padding-top |11px)
                  comp-leaf (read-field state :right?)
                    fn (v d!)
                      d! cursor $ assoc state :right? v
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] 'Dynamic
            :features $ #{} :js-ffi
        'style-button $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def style-button
            {} (:margin "|0 6px") (:cursor :pointer) (:font-family ui/font-fancy)
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.comp.container
          :require (respo-ui.core :as ui)
            respo.util.format :refer $ hsl
            respo.core :refer $ defcomp defeffect <> >> div button textarea span input list->
            respo.comp.space :refer $ =<
            respo.comp.inspect :refer $ comp-inspect
            reel.comp.reel :refer $ comp-reel
            respo-md.comp.md :refer $ comp-md
            app.config :refer $ dev?
            reel.schema :refer $ read-field
    'app.config $ %{} 'FileEntry
      :defs $ {}
        'dev? $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def dev?
            = |dev $ option:unwrap-or (get-env |mode) |release
          :examples $ []
          :schema $ :: 'Dynamic
        'site $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def site
            {} $ :storage-key |workflow
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.config
    'app.main $ %{} 'FileEntry
      :defs $ {}
        '*reel $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defatom *reel
            -> reel-schema/reel (assoc :base schema/store) (assoc :store schema/store)
          :examples $ []
          :schema $ :: 'Ref 'Dynamic
        'dispatch! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn dispatch! (op)
            when config/dev? $ println |Dispatch: op
            reset! *reel $ reel-updater updater @*reel op
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ [] 'Dynamic
        'main! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn main! ()
            println "|Running mode:" $ if config/dev? |dev |release
            if config/dev? $ load-console-formatter!
            render-app!
            add-watch *reel :changes $ fn (reel prev) (render-app!)
            listen-devtools! |k dispatch!
            js/window.addEventListener |beforeunload $ fn (event) (persist-storage!)
            repeat! 60 persist-storage!
            let
                raw $ js/localStorage.getItem $ :storage-key config/site
              when (js-present? raw)
                dispatch! $ :: :hydrate-storage $ parse-cirru-edn (unsafe-coerce raw String)
            println "|App started."
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'mount-target $ %{} 'CodeEntry (:doc |)
          :code $ quote $ def mount-target (js/document.querySelector |.app)
          :examples $ []
          :schema $ :: 'Dynamic
        'persist-storage! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn persist-storage! ()
            do
              js/localStorage.setItem (:storage-key config/site)
                format-cirru-edn $ reel-schema/read-field @*reel :store
              , &unit
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'reload! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn reload! ()
            if (nil? build-errors)
              do (remove-watch *reel :changes) (clear-cache!)
                add-watch *reel :changes $ fn (reel prev) (render-app!)
                reset! *reel $ refresh-reel @*reel schema/store updater
                hud! |ok~ |Ok
              hud! |error build-errors
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
        'render-app! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn render-app! ()
            render! (js/document.querySelector |.app)
              assert-type (comp-container @*reel) 'respo.schema/Component
              , dispatch!
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Unit)
            :args $ []
            :features $ #{} :js-ffi
        'repeat! $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn repeat! (duration cb)
            do
              js/setTimeout
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
            reel.core :refer $ reel-updater refresh-reel
            reel.schema :as reel-schema
            app.config :as config
            |./calcit.build-errors :default build-errors
            |bottom-tip :default hud!
    'app.schema $ %{} 'FileEntry
      :defs $ {} $ 'store
        %{} 'CodeEntry (:doc |)
          :code $ quote $ def store
            {} $ :states $ {}
              :cursor $ []
          :examples $ []
          :schema $ :: 'Dynamic
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.schema
    'app.updater $ %{} 'FileEntry
      :defs $ {}
        'clear-states $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn clear-states (store cursor)
            dissoc-in store $ prepend cursor :states
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] 'Dynamic 'Dynamic
        'updater $ %{} 'CodeEntry (:doc |)
          :code $ quote $ defn updater (store op op-id op-time)
            match op
              (:states cursor s) (update-states store cursor s)
              (:clear-states cursor) (clear-states store cursor)
              (:hydrate-storage data) data
              _ $ do (eprintln "|Unknown op:" op) store
          :examples $ []
          :schema $ :: 'Fn $ {} (:return 'Dynamic)
            :args $ [] 'Dynamic 'Dynamic 'String 'Number
      :ns $ %{} 'NsEntry (:doc |)
        :code $ quote $ ns app.updater
          :require $ respo.cursor :refer $ update-states
