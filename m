From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 May 2009 12:37:05 +0000
Subject: Re: [PATCH] sh: remove old TMU driver
Message-Id: <aec7e5c30905140537o62877d75r36a937b48e37911d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090512102554.25836.30844.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090512102554.25836.30844.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Jean-Christophe,

On Thu, May 14, 2009 at 9:27 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 19:25 Tue 12 May =A0 =A0 , Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> This patch removes the old TMU driver (CONFIG_SH_TMU/timer-tmu.c)
>>
>> As replacement, select the sh_tmu driver with CONFIG_SH_TIMER_TMU
>> and configure timer channel using platform data.
>>
>> If multiple TMU channels are enabled using platform data, use the
>> earlytimer parameter on the kernel command line to select channel.
>> For instance, use "earlytimer=3Dsh_tmu.0" to select the first channel.
>>
>> To verify which timer is being used, look at printouts or the timer
>> irq count in /proc/interrupts.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> ---
> Is there a git where I can sync to have your patch set?
> I'd to test on the r2dplus (real hw and qemu)

Latest sh-2.6.git tree has all the timer stuff merged. I've actually
already tested on r2d plus hardware a bit - one of my target platforms
- but more testing is always welcome. =3D)

Cheers,

/ magnus
