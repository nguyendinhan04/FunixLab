
//create usAdultIncome collection to store data from csv file
// import csv file to usAdultIncome collection using mongo compass

use("ASM2");
function loadEducation() {
	const bulkInsert = db.education.initializeUnorderedBulkOp();
	// Get all Documents in 'full' Collection
	const documents = db.usAdultIncome.find();

	// Process each document
	documents.forEach(function (doc) {
		const element = {
			education: doc.education,
			education_num: doc.education_num,
		};
		// Upsert into education Document
		bulkInsert.find(element).upsert().replaceOne(element);
	});
	bulkInsert.execute();
	return true;
}
loadEducation();

use("ASM2");
function loadOccupation() {
	const bulkInsert = db.occupation.initializeUnorderedBulkOp();
	// Get all Documents in 'full' Collection
	const documents = db.usAdultIncome.find();

	// Process each document
	documents.forEach(function (doc) {
		const element = {
			occupation: doc.occupation,
			workclass: doc.workclass,
			hour_per_week: doc.hours_per_week,
		};
		// Upsert into education Document
		bulkInsert.find(element).upsert().replaceOne(element);
	});
	bulkInsert.execute();
	return true;
}
loadOccupation();

use("ASM2");
function loadPersonlInfo() {
	const bulkInsert = db.personlInfo.initializeUnorderedBulkOp();
	// Get all Documents in 'full' Collection
	const documents = db.usAdultIncome.find();

	// Process each document
	documents.forEach(function (doc) {
		const element = {
			race: doc.native,
			native_country: doc.native_country,
			age: doc.age,
			gender: doc.gender,
		};
		// Upsert into education Document
		bulkInsert.find(element).upsert().replaceOne(element);
	});
	bulkInsert.execute();
	return true;
}
loadPersonlInfo();

use("ASM2");
function loadFinance() {
	const bulkInsert = db.finance.initializeUnorderedBulkOp();
	// Get all Documents in 'full' Collection
	const documents = db.usAdultIncome.find();

	// Process each document
	documents.forEach(function (doc) {
		const element = {
			income_bracket: doc.income_bracket,
		};
		// Upsert into education Document
		bulkInsert.find(element).upsert().replaceOne(element);
	});
	bulkInsert.execute();
	return true;
}
loadFinance();


use("ASM2");
db.education.createIndex({ education: 1 });

use("ASM2");
db.personlInfo.createIndex({ native_country: 1 });

use("ASM2");
db.relationship.createIndex({ relationship: 1, marital_status: 1 });

use("ASM2");
db.occupation.createIndex({ occupation: 1, workclass: 1, hour_per_week: 1 });


use("ASM2");
function loadUser() {
	const bulkInsert = db.user.initializeUnorderedBulkOp();
	// Get all Documents in 'full' Collection
	const documents = db.usAdultIncome.find({});

	// Process each document
	documents.forEach(function (doc) {
		const element = {
			capital_gain: doc.capital_gain,
			capital_loss: doc.capital_loss,
			total: doc.total,
		};

		// Get education PK
		const education = db.education.findOne({
			education: doc.education,
			education_num: doc.education_num,
		});
		element.education_id = education._id;

		// Get occupation PK
		const occupation = db.occupation.findOne({
			occupation: doc.occupation,
			workclass: doc.workclass,
			hour_per_week: doc.hours_per_week,
		});
		element.occupation_id = occupation._id;

		const personlInfo = db.personlInfo.findOne({
			race: doc.native,
			native_country: doc.native_country,
			age: doc.age,
			gender: doc.gender,
		});
		element.personlInfo_id = personlInfo._id;

		const finance = db.finance.findOne({
			income_bracket: doc.income_bracket,
		});
		element.finance_id = finance._id;

		const relationship = db.relationship.findOne({
			relationship: doc.relationship,
			marital_status: doc.marital_status,
		});
		element.relationship_id = relationship._id;

		// Upsert into user collection
		bulkInsert.find(element).upsert().replaceOne(element);
	});

	bulkInsert.execute();
	return true;
}
loadUser();