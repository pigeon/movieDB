# movieDB

# Architecture

                        +-------------+
                        |             |
                        |   Service   |
                        |             |
                        |             |
                        +------+------+
                                ^
                        +------+------+
                        |             |
                        |             +<-------------+
                        | Repository  |              |
                        |             |              |
                        +-------------+              |
                    +--------------------------------------------------------+
                    |             |                     |                    |
                    |      +------+-------+       +-----+-------+            |
                    |      |              |       |             |            |
                    |      | ViewModel    |       | ViewModel   |            |
                    |      |              |       |             |            |
                    |      +-------+------+       +------+------+      +-----+-----+
                    |              ^                     ^             |           |
                    |              |                     |             |   Router  |
                    |              |                     |             |           |
                    |      +-------+--------+     +------+---------+   +-----------+
                    |      |                |     |                |         |
                    |      | ViewController |     | ViewController |         |
                    |      |                |     |                |         |
                    |      +----------------+     +----------------+         |
                    |                                                        |
                    +--------------------------------------------------------+
