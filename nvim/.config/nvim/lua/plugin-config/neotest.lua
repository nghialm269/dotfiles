local neotest = require("neotest")
neotest.setup({
	adapters = {
		require("neotest-go"),
	},
})

-- Run tests
n.map("n", "<localleader>tn", neotest.run.run, "Run nearest test")

n.map("n", "<localleader>tf", function()
	neotest.run.run(vim.fn.expand("%"))
end, "Run current file")

n.map("n", "<localleader>td", function()
	neotest.run.run({ stragegy = "dap" })
end, "Debug nearest test")

n.map("n", "<localleader>tS", neotest.run.stop, "Stop nearest test")
n.map("n", "<localleader>ta", neotest.run.attach, "Attach to nearest test")

-- Output
n.map("n", "<localleader>to", neotest.output.open, "Display the output of test results")
n.map("n", "<localleader>ts", neotest.summary.toggle, "Display the summary of the test suite with results")
