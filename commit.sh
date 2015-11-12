#!/bin/sh

# Assuming:
#
# 1. Results of dumping each version of Xcode is in /Users/bgesiak/Desktop/Public-Headers/
# 2. Git repository for XCTest-Public-Headers is in /Users/bgesiak/GitHub/modocache/XCTest-Public-Headers/
# 3. The initial commit of that repository has a hash of 91a9a17726f1e2a0e10369b92f127222a3e331c6
#
# Then this script will copy the dumped headers into the repository, and force commit
# each one in sequence.
#
# As you can see, this code is generic and can be reused easily--all you have to do is be me,
# and own my laptop.

cd /Users/bgesiak/GitHub/modocache/XCTest-Public-Headers && \
git reset --hard 91a9a17726f1e2a0e10369b92f127222a3e331c6 && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 3.2/ . && git add . && git commit --allow-empty -m "Xcode 3.2" && git tag -f "Xcode3.2" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.3\ \(4E109\)/ . && git add . && git commit --allow-empty -m "Xcode 4.3 (4E109)" && git tag -f "Xcode4.3-4E109" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.3.1\ \(4E1019\)/ . && git add . && git commit --allow-empty -m "Xcode 4.3.1 (4E1019)" && git tag -f "Xcode4.3.1-4E1019" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.3.2\ \(4E2002\)/ . && git add . && git commit --allow-empty -m "Xcode 4.3.2 (4E2002)" && git tag -f "Xcode4.3.2-4E2002" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.3.3\ \(4E3002\)/ . && git add . && git commit --allow-empty -m "Xcode 4.3.3 (4E3002)" && git tag -f "Xcode4.3.3-4E3002" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.4/ . && git add . && git commit --allow-empty -m "Xcode 4.4" && git tag -f "Xcode4.4" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.4.1\ \(4F1003\)/ . && git add . && git commit --allow-empty -m "Xcode 4.4.1 (4F1003)" && git tag -f "Xcode4.4-4F1003" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.5/ . && git add . && git commit --allow-empty -m "Xcode 4.5" && git tag -f "Xcode4.5" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.5.1/ . && git add . && git commit --allow-empty -m "Xcode 4.5.1" && git tag -f "Xcode4.5.1" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.5.2\ \(4G2008\)/ . && git add . && git commit --allow-empty -m "Xcode 4.5.2 (4G2008)" && git tag -f "Xcode4.5.2-4G2008" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.6\ \(4H127\)/ . && git add . && git commit --allow-empty -m "Xcode 4.6 (4H127)" && git tag -f "Xcode4.6-4H127" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.6.1\ \(4H512\)/ . && git add . && git commit --allow-empty -m "Xcode 4.6.1 (4H512)" && git tag -f "Xcode4.6.1-4H512" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.6.2\ \(4H1003\)/ . && git add . && git commit --allow-empty -m "Xcode 4.6.2 (4H1003)" && git tag -f "Xcode4.6.2-4H1003" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 4.6.3\ \(4H1503\)/ . && git add . && git commit --allow-empty -m "Xcode 4.6.3 (4H1503)" && git tag -f "Xcode4.6.3-4H1503" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 5.0\ \(5A1413\)/ . && git add . && git commit --allow-empty -m "Xcode 5.0 (5A1413)" && git tag -f "Xcode5.0-5A1413" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 5.0.1\ \(5A2053\)/ . && git add . && git commit --allow-empty -m "Xcode 5.0.1 (5A2053)" && git tag -f "Xcode5.0.1-5A2053" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 5.0.2\ \(5A3005\)/ . && git add . && git commit --allow-empty -m "Xcode 5.0.2 (5A3005)" && git tag -f "Xcode5.0.2-5A3005" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 5.1\ \(5B130a\)/ . && git add . && git commit --allow-empty -m "Xcode 5.1 (5B130a)" && git tag -f "Xcode5.1-5B130a" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 5.1.1\ \(5B1008\)/ . && git add . && git commit --allow-empty -m "Xcode 5.1.1 (5B1008)" && git tag -f "Xcode5.1.1-5B1008" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 6.0.1\ \(6A317\)/ . && git add . && git commit --allow-empty -m "Xcode 6.0.1 (6A317)" && git tag -f "Xcode6.0.1-6A317" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 6.1\ \(6A1052d\)/ . && git add . && git commit --allow-empty -m "Xcode 6.1 (6A1052d)" && git tag -f "Xcode6.1-6A1052d" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 6.1.1\ \(6A2008a\)/ . && git add . && git commit --allow-empty -m "Xcode 6.1.1 (6A2008a)" && git tag -f "Xcode6.1.1-6A2008a" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 6.2\ \(6C131e\)/ . && git add . && git commit --allow-empty -m "Xcode 6.2 (6C131e)" && git tag -f "Xcode6.2-6C131e" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 6.3\ \(6D570\)/ . && git add . && git commit --allow-empty -m "Xcode 6.3 (6D570)" && git tag -f "Xcode6.3-6D570" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 6.3.1\ \(6D1002\)/ . && git add . && git commit --allow-empty -m "Xcode 6.3.1 (6D1002)" && git tag -f "Xcode6.3.1-6D1002" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 6.3.2\ \(6D2105\)/ . && git add . && git commit --allow-empty -m "Xcode 6.3.2 (6D2105)" && git tag -f "Xcode6.3.2-6D2105" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 6.4\ \(6E35b\)/ . && git add . && git commit --allow-empty -m "Xcode 6.4 (6E35b)" && git tag -f "Xcode6.4-6E35b" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 7.0\ \(7A220\)/ . && git add . && git commit --allow-empty -m "Xcode 7.0 (7A220)" && git tag -f "Xcode7.0-7A220" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 7.0.1\ \(7A1001\)/ . && git add . && git commit --allow-empty -m "Xcode 7.0.1 (7A1001)" && git tag -f "Xcode7.0.1-7A1001" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 7.1b1/ . && git add . && git commit --allow-empty -m "Xcode 7.1b1" && git tag -f "Xcode7.1b1" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 7.1b2\ \(7B75\)/ . && git add . && git commit --allow-empty -m "Xcode 7.1b2 (7B75)" && git tag -f "Xcode7.1b2-7B75" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 7.1b5/ . && git add . && git commit --allow-empty -m "Xcode 7.1b5" && git tag -f "Xcode7.1b5" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 7.1b6/ . && git add . && git commit --allow-empty -m "Xcode 7.1b6" && git tag -f "Xcode7.1b6" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 7.1\ \(7B91b\)/ . && git add . && git commit --allow-empty -m "Xcode 7.1 (7B91b)" && git tag -f "Xcode7.1-7B91b" && \
rm -rf SenTestingKit.framework XCTest.framework && cp -r /Users/bgesiak/Desktop/Public-Headers/Xcode\ 7.1.1\ \(7B1005\)/ . && git add . && git commit --allow-empty -m "Xcode 7.1.1 (7B1005)" && git tag -f "Xcode7.1.1-7B1005"
