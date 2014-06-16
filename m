From: Simon Horman <horms@verge.net.au>
Date: Mon, 16 Jun 2014 12:29:03 +0000
Subject: Koelsch on v3.16-rc1
Message-Id: <20140616122903.GB30357@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

I have noticed that Koelsch does not appear to boot on v3.16-rc1.
This appears to affect both legacy C (koelsch_defconfig) and
multiplatform (shmobile_defconfig).

I have not tested to see if this affects any other boards yet.

I am currently bisecting the problem (using shmobile_defconfig).

However, its a little late in the day and I may not get much further than
that today.

