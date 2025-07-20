// tim so nguoi Bachelors o My
use('ASM2')
db.user.aggregate([
	{
		$lookup: {
			from: "education",
			localField: "education_id",
			foreignField: "_id",
			as: "education"
		}
	}
])