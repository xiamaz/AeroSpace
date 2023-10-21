struct ModeCommand: Command {
    let idToActivate: String

    func runWithoutRefresh() {
        precondition(Thread.current.isMainThread)
        activateMode(idToActivate)
    }
}

var activeMode: String = mainModeId
func activateMode(_ modeToActivate: String) {
    for (modeId, mode) in config.modes {
        if modeId != modeToActivate {
            mode.deactivate()
        }
    }
    for (modeId, mode) in config.modes {
        if modeId == modeToActivate {
            for binding in mode.bindings {
                binding.activate()
            }
        }
    }
    activeMode = modeToActivate
}
