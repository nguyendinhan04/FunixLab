// Bai 1
db.Lab7.find({firstName : {$eq : "Pauline"}, lastName : {$eq: "Fournier"}}).count()
// Bai 2
db.Lab7.find({firstName : {$eq : "Pauline"}, lastName : {$eq: "Fournier"}, "birthDate" : {$lt : ISODate('1970-01-01T00:00:00Z')}}).count()
// Bai 3:
db.Lab7.find({$or : [{firstName : {$eq : "Lucas"}, lastName : {$eq: "Dubois"}}, {firstName : {$eq : "Camille"}, lastName : {$eq: "Dubois"}}]}).count()
// Bai 4:
db.Lab7.find({"wealth.credits" : {$eq : []}}).count()
// Bai 5:   
db.Lab7.find({"payments" : {$elemMatch : {"name" : "cinema","amount" : 12.99}}}).count()

db.Lab7.find({"payments.amount" : 12.99}).count()
// Bai 6:
db.Lab7.find({$and : [{"payments.0.amount" : {$eq : 12.99}},{"payments.0.name" : {$eq : "cinema"}}]}).count()

// Bai 7:
db.Lab7.find({$nor : [{"payments.name":"cinema"}]}).count()
// Bai 8:

use('Lab7');
db.Lab7.find({$and : [{"sex" : "female"}, {"payments" : {$elemMatch : {"name" : "shoes", "amount" : {$gt : 100}}
}}, {"payments" : {$elemMatch :{"name" : "pants", "amount" : {$gt : 50}}
}}]});

// Bai 9: 
use('Lab7');
db.Lab7.find({$and : [{"address.country" : {$eq : "Poland"}},{"address.city" : {$eq : "Warsaw"}},{"payments" : {$elemMatch : {"name" : "cinema"}}},  {"payments" : {$not : {$elemMatch : {"name" : "disco"}}}}]}).count()

// Bai 10:
use('Lab7');
db.Lab7.find({
    $and : [
        {
            $or: [
                {
                    $and:[
                        {"sex" : "male"},{"address.city" : "Cracow"}
                    ]
                },
                {
                    $and : [
                        {"sex" : "female"},{"address.city" : "Paris"}
                    ]
                }
            ]
        },
        {
            "wealth.realEstates": {
                $all: [
                    { $elemMatch: { "type": "house", "worth" : {$gte: 500000}} },
                    { $elemMatch: { "type": "flat", "worth" : {$gte: 500000} } },
                    { $elemMatch: { "type": "land", "worth" : {$gte: 500000} } },
                    { $elemMatch: { "type": {$in: ["house", "flat", "land"]}, "worth" : {$gt : 2000000}}}
                ]
            }
        }
    ]
}).count()

// Bai 11:
use('Lab7');
db.Lab7.find({
    "payments" : {$size : 10}
}).count()


// Bai 12:
use('Lab7');
db.Lab7.find({
    "firstName" : 'Thomas'
},{"_id" : 1, "firstName" : 1, "lastName" : 1})

// Bai 13:
use('Lab7');
db.Lab7.find({
    "payments" : {
        $elemMatch : {
            "amount" : {$lt : 5}
        }
    }
}, {"firstName" : 1, "lastName" : 1, "payments" : {$elemMatch : {"amount" : {$lt : 5}}}})

// Bai 14:
use('Lab7');
db.Lab7.updateMany(
    {"address.country" : "France"},{$push : {"payments" : {"category" : "relax", "name" : "disco", "amount" : 5.06}}}
)

// Bai 15:
use('Lab7');
db.Lab7.updateMany({},{$unset : {"wealth.market" : ""}})
