use('Lab8')
db.people.find({})

// Bai 1:
use('Lab8')
db.people.aggregate([
    {
        $group : {_id :  "$address.country",  total : {$sum : 1}}
    }
])
// Bai 2:
use('Lab8')
db.people.aggregate([
    {
        $group : {_id :  "$address",  total : {$sum : 1}}
    },
    {
        $sort : {total : -1},
    },
    {
        $limit: 1
    }
])


// Bai 3:
use('Lab8')
db.people.aggregate([
    {
        $match: {"payments" : {$elemMatch : {"name" : "restaurant"}}}
    },
    {
        $group : {_id: "$address.country", "visit" : {$sum : 1}}
    }
])

// Bai 4:
use('Lab8')
db.people.aggregate([
    {
        $project: {
            "_id" : 0,
            "firstName":1,
            "lastName":1,
            "totalBalance" : {$sum : "$wealth.bankAccounts.balance"}
        }
    },  
    {
        $sort : {
            "totalBalance" : -1,
            "lastName" : 1,
            "firstName" : 1
        }
    },
    {
        $limit : 3
    }
])

// Bai 5:
use('Lab8')
db.people.aggregate([
    { $match : {"payments" : {$elemMatch : {"name" : "restaurant"}}} },
    { $unwind: "$payments" },
    { $match : {"payments.name" : "restaurant"} },
    {
        $group : {
            _id : "$address.country",
            "totalVisits" : {$sum : 1},
            "totalAmount" : {$sum : "$payments.amount"},
            "avgAmount" : {$avg : "$payments.amount"}
        }
    }
])

// Bai 6:
use('Lab8')
db.people.aggregate([
    { $match : {"payments" : {$elemMatch : {"name" : "restaurant"}}} },
    { $unwind: "$payments" },
    { $match : {"payments.name" : "restaurant"} },
    {
        $group : {
            _id : "$address.country",
            "avgAmount" : {$avg : "$payments.amount"}
        }
    },
    {
        $group : {
            _id: null,
            "lowestAvgAmount" : {$min : "$avgAmount"},
            "highestAvgAmount" : {$max : "$avgAmount"}
        }
    },
    {
        $project :{
            "_id": null,
            "diff" : {$divide : ["$highestAvgAmount", "$lowestAvgAmount"]}
        }
    }
])

// Bai 7:
use('Lab8')
db.people.aggregate([
    {
        $unwind: "$payments"
    },
    {
        $match : {"payments.amount" : {$lt : 5}}
    },
    {
        $group : {
            _id : "$_id",
            "firstName" : {$first : "$firstName"},
            "lastName" : {$first : "$lastName"},
            "payments" : {$push : "$payments"} ,
        }
    }
])


use('Lab8')
db.people.aggregate([
    {
        $unwind: "$payments"
    },
    {
        $match : {"payments.amount" : {$lt : 5}}
    },
    {
        $group: {
            _id : {"firstName" : "$firstName", "lastName" : "$lastName"},
            "payments" : {$push : "$payments"}
        }
    }
])


// Bai 8:
use('Lab8')
db.people.aggregate([
    {
        $unwind: "$payments"
    },
    {$group: {
        "_id":{ "firstName" :"$firstName", "lastName" : "$lastName", "category" :"$payments.category"},
        "total": {$sum : "$payments.amount"}

    }},
    {
        $group : {
            _id : {"firstName" : "$_id.firstName", "lastName" : "$_id.lastName"},
            "totalPayments" : {$push : {"category" : "$_id.category", "amount" : "$total"}}
        }
    },
    {
        $project : {
            "_id" : 0,
            "firstName" : "$_id.firstName",
            "lastName" : "$_id.lastName",
            "totalPayments" : 1
        }
    }
])


// Bai 9:
use('Lab8')
db.people.aggregate([
    {
        $project : {
            "address.country" : 1,
            "currAge" : {$dateDiff : {
                startDate : "$birthDate", 
                endDate : {$dateFromString : {dateString : "2016-06-22"}},
                unit : "year"
            }}
        }
    },
    {
        $match : { $and:  [{"currAge" : {$gt : 17}}, {"currAge" : {$lt : 50}}]}
    },
    {
        $project : {
            "address.country" : 1,
            "ageRange" : {
                $switch : {
                    branches : [
                        {case  : {$lt : ["$currAge", 30]}, then : "18-29"},
                        {case  : {$lt : ["$currAge", 40]}, then : "30-39"},
                        {case  : {$lt : ["$currAge", 50]}, then : "40-49"}
                    ]
                }
            }
        }
    },
    {
        $group : {
            _id : {"country" : "$address.country", "ageRange" : "$ageRange"},
            "count" : {$sum : 1}
        }
    }
])


// Bai 10:
use('Lab8')
use('Lab8')
db.people.aggregate([
    {
        $project : {
            "address.country" : 1,
            "currAge" : {$dateDiff : {
                startDate : "$birthDate", 
                endDate : {$dateFromString : {dateString : "2016-06-22"}},
                unit : "year"
            }}
        }
    },
    {
        $project : {
            "address.country" : 1,
            "ageRange" : {
                $switch : {
                    branches : [
                        {case  : {$lt : ["$currAge", 30]}, then : "18-29"},
                        {case  : {$lt : ["$currAge", 40]}, then : "30-39"},
                        {case  : {$lt : ["$currAge", 50]}, then : "40-49"},
                    ],
                    default : "other"
                }
            }
        }
    },
    {
        $group : {
            _id : {"country" : "$address.country", "ageRange" : "$ageRange"},
            "count" : {$sum : 1}
        }
    },
    {
        $group : {
            _id : {"country" : "$_id.country"},
            "count" : {$sum : "$count"},
            "ageRange" : {$push : {"ageRange" : "$_id.ageRange", "count" : "$count"}}
        }
    },
    {
        $unwind: "$ageRange"
    },
    {
        $project: {
            "_id" : {"country" : "$_id.country", "ageRange" : "$ageRange.ageRange"},
            "percentage" : {$divide : [{$divide : ["$ageRange.count", "$count"]}, 0.01]}
        }
    }
])



