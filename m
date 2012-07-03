From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Tue, 03 Jul 2012 10:31:38 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <4FF2CA0A.6090306@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello, Guennadi

(2012/07/03 19:12), Guennadi Liakhovetski wrote:
> Hello
>
> On Tue, 3 Jul 2012, Tetsuyuki Kobayashi wrote:
>
>> Add REGULATOR settings to kernel config file of kzm9g.
>>
>> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
>> ---
>> Hello,
>>
>> I found Guennadi's
>> "ARM: mach-shmobile: add fixed voltage regulators to kzm9g"
>> requires REGULATOR setting in kernel config.
>> Without this, it causes these errors at boot time.
>
> Thanks for the patch. However, I think, this error will only appear if you
> enable REGULATOR in the kernel, but both REGULATOR_FIXED_VOLTAGE and
> REGULATOR_DUMMY are disabled. To fix this fixing the defconfig is good,

Oh yes, you are right. I made bad combination as you said.
if CONFIG_REGULATOR is not set, it goes well as before.

> but not sufficient, I think. How about adding something like
>
> 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
>
> to either the CPU or the arch section in respective Kconfig? I would
> actually propose to add these to both arm/mach-shmobile and sh. Any
> objections?
>

Thank you.
I withdraw my config patch and wait for your proposal to Kconfig.


