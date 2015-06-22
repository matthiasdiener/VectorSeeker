#ifndef resultvector_H
#define resultvector_H
#include <vector>
#include <unordered_map>
#include <map>

using std::unordered_map;
using std::map;
using std::vector;
using std::pair;

class ResultVector
{
private:
	unordered_map<long,long long> vectors;	// most used how to speed up?
										// crashes if made a map why?
	long execution_count;

public:
	ResultVector(){execution_count=0;};
	void addToDepth(long depth);
	long readDepthCount(long depth);
	bool isSingle();
	void sortedVectors(vector<pair<long,long> > &sorted_vectors);
	bool vectorsGreater(int minVector);
	void clear();
	long getExecutionCount();
};

#endif
