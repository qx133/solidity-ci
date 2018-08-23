var helloworld = artifacts.require("./helloworld.sol");

contract('helloworld', function(accounts) {
	it("should call function greet", function() {
		var contractInstance;
		return helloworld.deployed().then(function(instance) {
			contractInstance = instance;
			return instance.greet();
		}).then(function(greeting) {
		return contractInstance.count.call();
		}).then(function(count) {
			assert.equal(count.toString(), "1", "count was not 1");
		});
	});

});

