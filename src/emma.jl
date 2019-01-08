function emma(data,model,opts)

    if model == "ACQR"

        y = data["y"]
        dt = data["dt"]

        ssm = ACQR_em_s1

        modes = modalparam(ssm["A"],ssm["C"],dt)

    elseif model == "ABCDQR"

        y = data["y"]
        u = data["u"]
        dt = data["dt"]
        dofu = data["dofu"]

        ssm = ACQR_em_s1

        modes = modalparami(ssm["A"],ssm["B"],ssm["C"],dt,dofu)

    end

    return modes
end
