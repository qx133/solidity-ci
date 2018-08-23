var helloworld = artifacts.require("./helloworld.sol");

contract('helloworld', function(accounts) {
  it("count should be 1", async () => {
    let instance = await helloworld.deployed();
    let greet1 = await instance.greet();
    let count = await instance.count.call();
    assert.equal(count.valueOf(), 1, "count was 0 before greet");
  });

  it("greeting should be hello world", function() {
    return helloworld.deployed().then(function(instance) {
      return instance.greeting.call();
    }).then(function(result) {
      assert.equal(result, "hello world");
    });
  });
  
});
