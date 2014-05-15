From: Simon Horman <horms@verge.net.au>
Date: Thu, 15 May 2014 05:22:27 +0000
Subject: [ANNOUNCE] Renesas Tree is Closed for v3.16
Message-Id: <20140515052227.GE778@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131230013640.GA1944@verge.net.au>
In-Reply-To: <20131230013640.GA1944@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

The Renesas tree is now closed for arm-soc changes for v3.16.

I am not planning to accept any more patches for v3.16 other than fixes[1].
Fixes and branches needing fixes[1] aside, I am planning to send the last
set of pull-requests for v3.16 tomorrow.

I have tagged renesas-next-v3.15-rc1-20140515 which includes all patches I
have queued up. I have also tagged renesas-devel-v3.15-rc5-20140515. The
only difference between the two tags is that the former is based on
v3.15-rc1 while the latter is includes v3.15-rc5.

I now plan to start queuing up patches for v3.17, making them them
available in the devel branch. I will rebase them on top of v3.16-rc1 once
it is released and the result will become available in the next branch at
that time.

I realise that there may be patches that people anticipated would make it
into v3.16 but have not. I sympathise with this but arm-soc has a cut-off
of v3.15-rc6 and this means I have to have things queued up well before
then. I believe that in this release cycle I have cut things as fine as
possible and in future I hope to close the Renesas tree soon after the
release of v3.16-rc5. Your understanding is appreciated.

Lastly, I will be in Tokyo for Linux Con Japan next week.
I apologise if that results in any delays.


[1] At this time the only fix I am waiting on is one to either fix
    or remove genmai-reference support.
    https://patchwork.kernel.org/patch/4173801/
    This affects only the r7s72100-ccf-for-v3.16 branch.
    https://git.kernel.org/cgit/linux/kernel/git/horms/renesas.git/log/?h=r7s72100-ccf-for-v3.16
