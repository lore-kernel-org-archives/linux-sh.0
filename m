From: morimoto.kuninori@renesas.com
Date: Fri, 23 Jan 2009 09:04:20 +0000
Subject: [bug report] dead lock (?) occur on ap325 board
Message-Id: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul.

I found dead lock (? freeze?) bug again on
------------------------------------------------
commit 77ba93a7ac5fb0d9338bffbf97c787b8efe00806
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Mon Dec 8 11:25:50 2008 +0900

    sh: Fix up the SH-4A mutex fastpath semantics.
------------------------------------------------

I get dead lock even if following patch is added
(this bug will be fixed on 06be3724548a443a99d703ff79f43d6f1e2975f0)
----------------
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Mon Dec 8 17:01:40 2008 +0900

    sh: Fix an off-by-1 check in __mutex_fastpath_unlock().
----------------

c6f17cb2272121475c87592560534b157b17544e is OK for me.
(but YOSHII-san's patch (3b041227f7ef7c7e97f205c68c6069c0c62e5204)
 is still needed.)

*** My envilonment ****

board:     ap325
gcc:       gcc 4.1.2 (Gentoo 4.1.2 p1.0.2)
defconfig: ap325_defconfig

*** Reproduction method ***

> git checkout 77ba93a7ac5fb0d9338bffbf97c787b8efe00806
> patch -p1 < 3b041227f7ef7c7e97f205c68c6069c0c62e5204.patch
> patch -p1 < 06be3724548a443a99d703ff79f43d6f1e2975f0.patch
> make

copy following string by consol application.
-------------
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
HOGE="Morimoto is stupid"
-------------

paste string many times on ap325 board.
------------
> HOGE="Morimoto is stupid"  <= paste string
> HOGE="Morimoto is stupid"
> HOGE="Morimoto is stupid"
...
> HOGE="Morimoto is stupid"  <= paste string
> HOGE="Morimoto is stupid"
> HOGE="Morimoto is stupid"
...
> HOGE="Morimoto is stupid"  <= paste string
> HOGE="Morimoto is stupid"
> HOG                        <= freeze
------------

/Morimoto
