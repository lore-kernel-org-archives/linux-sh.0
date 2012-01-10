From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 10 Jan 2012 08:22:49 +0000
Subject: Re: [PATCH] arm: mach-shmobile: add a resource name for shdma
Message-Id: <4F0BF559.1060402@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0BCADB.8010709@renesas.com>
In-Reply-To: <4F0BCADB.8010709@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

2012/01/10 16:43, Paul Mundt wrote:
> On Tue, Jan 10, 2012 at 02:21:31PM +0900, Shimoda, Yoshihiro wrote:
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  This patch depends on the following patch:
>>    - dmaengine: shdma: modify the DMAC Address Error registration
>>
> What exactly does it depend on? If it's just wiring up the string, we can
> merge that at any time, and the earlier the better. Setting the string
> doesn't introduce any different behaviour in the driver as it is now
> without the change in registration.
> 

I'm sorry for my wrong comment. Your point is correct.
This patch doesn't depend on the shdma's patch.

Should I submit the patch which removed the comment again?

Best regards,
Yoshihiro Shimoda

-- 
Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
EC No.
