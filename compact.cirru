
{} (:package |app)
  :configs $ {} (:init-fn |app.main/main!) (:reload-fn |app.main/reload!)
    :modules $ [] |respo.calcit/ |lilac/ |memof/ |respo-ui.calcit/ |respo-markdown.calcit/ |reel.calcit/
    :version |0.0.1
  :files $ {}
    |app.comp.container $ {}
      :ns $ quote
        ns app.comp.container $ :require (respo-ui.core :as ui)
          respo.util.format :refer $ hsl
          respo.core :refer $ defcomp defeffect <> >> div button textarea span input list->
          respo.comp.space :refer $ =<
          respo.comp.inspect :refer $ comp-inspect
          reel.comp.reel :refer $ comp-reel
          respo-md.comp.md :refer $ comp-md
          app.config :refer $ dev?
      :defs $ {}
        |comp-container $ quote
          defcomp comp-container (reel)
            let
                store $ :store reel
                states $ :states store
                cursor $ or (:cursor states) ([])
                state $ or (:data states)
                  {} (:content "\"") (:size 1)
              div
                {} $ :style (merge ui/global ui/column)
                div ({})
                  span $ {} (:style style-button) (:inner-text "\"Less")
                    :on-click $ fn (e d!)
                      if
                        > (:size state) 1
                        d! cursor $ update state :size dec
                  span $ {} (:style style-button) (:inner-text "\"More")
                    :on-click $ fn (e d!)
                      d! cursor $ update state :size inc
                list->
                  {} $ :style
                    merge ui/row $ {} (:flex-wrap :wrap)
                  -> (:size state) (or 1) (range)
                    map $ fn (idx)
                      [] idx $ div
                        {} $ :style
                          {} (:margin "\"8px") (:padding 8)
                            :border $ str "\"1px solid " (hsl 0 0 90)
                        div
                          {} $ :style
                            {} (:text-align :center) (:line-height "\"16px")
                          <> $ str idx
                        comp-quaternary $ >> states idx
                when dev? $ comp-reel (>> states :reel) reel ({})
                when dev? $ comp-inspect "\"reel" states
                  {} $ :bottom 0
        |comp-leaf $ quote
          defcomp comp-leaf (v? on-change)
            div $ {}
              :style $ {} (:width 16) (:height 16) (:cursor :pointer)
                :background-color $ if v? (hsl 200 80 50) (hsl 0 0 80)
              :on-click $ fn (e d!)
                on-change (not v?) d!
        |comp-branch $ quote
          defcomp comp-branch (states v on-change)
            let
                cursor $ :cursor states
              div
                {} $ :style ({})
                div
                  {} (:class-name "\"controller")
                    :style $ {} (:text-align :center) (:line-height "\"10px") (:font-size 12) (:cursor :pointer)
                    :on-click $ fn (e d!)
                      if (keyword? v)
                        do (on-change false d!) (d! :clear-states cursor)
                        on-change :branch d!
                  <> $ if (keyword? v) "\"x" "\"Br"
                if (bool? v)
                  comp-leaf v $ fn (next d!) (on-change next d!)
                  comp-quaternary states 
        |comp-quaternary $ quote
          defcomp comp-quaternary (states)
            let
                cursor $ :cursor states
                state $ or (:data states)
                  {} (:left? false) (:right? false) (:a false) (:b false)
              div
                {} $ :style
                  merge ui/row $ {} (:display :inline-flex)
                div
                  {} $ :style
                    {} $ :padding-top "\"11px"
                  comp-leaf (:left? state)
                    fn (v d!)
                      d! cursor $ assoc state :left? v
                =< 2 nil
                comp-branch (>> states :a) (:a state)
                  fn (v d!)
                    d! cursor $ assoc state :a v
                =< 2 nil
                comp-branch (>> states :b) (:b state)
                  fn (v d!)
                    d! cursor $ assoc state :b v
                =< 2 nil
                div
                  {} $ :style
                    {} $ :padding-top "\"11px"
                  comp-leaf (:right? state)
                    fn (v d!)
                      d! cursor $ assoc state :right? v
        |style-button $ quote
          def style-button $ {} (:margin "\"0 6px") (:cursor :pointer) (:font-family ui/font-fancy)
    |app.schema $ {}
      :ns $ quote (ns app.schema)
      :defs $ {}
        |store $ quote
          def store $ {}
            :states $ {}
              :cursor $ []
    |app.updater $ {}
      :ns $ quote
        ns app.updater $ :require
          respo.cursor :refer $ update-states
      :defs $ {}
        |clear-states $ quote
          defn clear-states (store op-data)
            dissoc-in store $ prepend op-data :states
        |updater $ quote
          defn updater (store op data op-id op-time)
            case-default op
              do (println "\"unknown op:" op) store
              :states $ update-states store data
              :clear-states $ clear-states store data
              :hydrate-storage data
    |app.main $ {}
      :ns $ quote
        ns app.main $ :require
          respo.core :refer $ render! clear-cache!
          app.comp.container :refer $ comp-container
          app.updater :refer $ updater
          app.schema :as schema
          reel.util :refer $ listen-devtools!
          reel.core :refer $ reel-updater refresh-reel
          reel.schema :as reel-schema
          app.config :as config
          "\"./calcit.build-errors" :default build-errors
          "\"bottom-tip" :default hud!
      :defs $ {}
        |render-app! $ quote
          defn render-app! () $ render! mount-target (comp-container @*reel) dispatch!
        |persist-storage! $ quote
          defn persist-storage! () $ .!setItem js/localStorage (:storage-key config/site)
            format-cirru-edn $ :store @*reel
        |mount-target $ quote
          def mount-target $ .!querySelector js/document |.app
        |*reel $ quote
          defatom *reel $ -> reel-schema/reel (assoc :base schema/store) (assoc :store schema/store)
        |main! $ quote
          defn main! ()
            println "\"Running mode:" $ if config/dev? "\"dev" "\"release"
            if config/dev? $ load-console-formatter!
            render-app!
            add-watch *reel :changes $ fn (reel prev) (render-app!)
            listen-devtools! |k dispatch!
            .!addEventListener js/window |beforeunload $ fn (event) (persist-storage!)
            repeat! 60 persist-storage!
            let
                raw $ .!getItem js/localStorage (:storage-key config/site)
              when (some? raw)
                dispatch! :hydrate-storage $ parse-cirru-edn raw
            println "|App started."
        |dispatch! $ quote
          defn dispatch! (op op-data)
            when
              and config/dev? $ not= op :states
              println "\"Dispatch:" op
            reset! *reel $ reel-updater updater @*reel op op-data
        |reload! $ quote
          defn reload! () $ if (nil? build-errors)
            do (remove-watch *reel :changes) (clear-cache!)
              add-watch *reel :changes $ fn (reel prev) (render-app!)
              reset! *reel $ refresh-reel @*reel schema/store updater
              hud! "\"ok~" "\"Ok"
            hud! "\"error" build-errors
        |repeat! $ quote
          defn repeat! (duration cb)
            js/setTimeout
              fn () (cb)
                repeat! (* 1000 duration) cb
              * 1000 duration
    |app.config $ {}
      :ns $ quote (ns app.config)
      :defs $ {}
        |dev? $ quote
          def dev? $ = "\"dev" (get-env "\"mode")
        |site $ quote
          def site $ {} (:storage-key "\"workflow")
