From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 08 Dec 2014 11:35:41 +0000
Subject: Re: stable boot: 93 boots: 92 pass, 1 fail (v3.17.6)
Message-Id: <2553650.3KSUKtTdo3@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sunday 07 December 2014 21:49:05 Kevin's boot bot wrote:
> Full Build report: http://status.armcloud.us/build/stable/kernel/v3.17.6/
> Full Boot report:  http://status.armcloud.us/boot/all/job/stable/kernel/v3.17.6/
> 
> Tree/Branch: stable
> Git describe: v3.17.6
> 
> Failed boot tests
> ========>                      emev2-kzm9d:     FAIL:    arm-shmobile_defconfig
>                                       http://storage.armcloud.us/kernel-ci/stable/v3.17.6/arm-shmobile_defconfig/boot-emev2-kzm9d.html
> 

I tried to look at the reports, but the links don't work. Going
back in the archive, I see that it was still working until v3.17.2,
broken in v3.17.4/.5/.6 and the boot report for v3.17.3 seemed to run
into an unrelated issue. Mainline was always fine since 3.17, only
the stable kernels had problems:

http://storage.armcloud.us/kernel-ci/stable/v3.17.2/arm-shmobile_defconfig/boot-emev2-kzm9d.html
http://storage.armcloud.us/kernel-ci/stable/v3.17.3/arm-shmobile_defconfig/boot-emev2-kzm9d.html
http://storage.armcloud.us/kernel-ci/stable/v3.17.4/arm-shmobile_defconfig/boot-emev2-kzm9d.html

It may be worth having the sh team investigate the problem some more,
to see if a bad patch made it into stable kernels.

	Arnd
