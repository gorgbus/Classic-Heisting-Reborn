if _G.ch_settings.settings.u24_progress then
    function JobManager:start_accumulate_ghost_bonus(job_id)
        self._global.active_ghost_bonus = nil
        self._global.accumulated_ghost_bonus = nil
    end

    function JobManager:accumulate_ghost_bonus()
        return 0
    end

    function JobManager:activate_accumulated_ghost_bonus()
        if self:current_job_id() ~= "safehouse" and self:current_job_id() ~= "chill" then
            self:_set_ghost_bonus(0, true)

            return
        end
    end
end