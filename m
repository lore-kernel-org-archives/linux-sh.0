From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 08 Jul 2012 15:01:46 +0000
Subject: Re: ARM: mach-shmobile: recent next build failure
Message-Id: <201207081701.46971.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sunday, July 08, 2012, Guennadi Liakhovetski wrote:
> Hi
> 
> Got this build failure with Friday's next:
> 
> linux/arch/arm/mach-shmobile/pm-sh7372.c: In function 'sh7372_pm_init':
> linux/arch/arm/mach-shmobile/pm-sh7372.c:598: error: implicit declaration of function 'sh7372_suspend_init'
> linux/arch/arm/mach-shmobile/pm-sh7372.c:599: error: implicit declaration of function 'sh7372_cpuidle_init'
> make[2]: *** [arch/arm/mach-shmobile/pm-sh7372.o] Error 1
> 
> .config available on request.

Please attach.

Magnus, that appears to be a result of your recent wakeup changes.

Thanks,
Rafael
