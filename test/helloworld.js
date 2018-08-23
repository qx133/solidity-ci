var helloworld = artifacts.require("./helloworld.sol");

contract('helloworld', function(accounts) {
  it("greeting should  be hello world ", function() {
    return helloworld.deployed().then(function(instance) {
      return instance.greeting.call();
    }).then(function(result) {
      assert.equal(result, "hello world");
    });
  });
  it("greet should  be hello world ", async () =>  {

    let inst = await helloworld.deployed();
    let greet = await inst.greet();
    let count = await inst.count.call();
    
    assert.equal(count, "1");
    
  });
})
