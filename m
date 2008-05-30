From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 30 May 2008 02:31:29 +0000
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Message-Id: <aec7e5c30805291931v23512403qa95554fe1602a1b2@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	<20080529024024.63d726de.akpm@linux-foundation.org>
In-Reply-To: <20080529024024.63d726de.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: lethal@linux-sh.org, linux-fbdev-devel@lists.sourceforge.net, linux-sh@vger.kernel.org

On Thu, May 29, 2008 at 6:40 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 29 May 2008 18:24:51 +0900 Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> This patch adds frame buffer support for the LCDC block found in
>> SuperH Mobile processors. The hardware supports up to two LCD panels
>> per LCDC block, and both RGB and SYS interfaces can be used to hook
>> up LCD panels/modules.
>>
>> The device driver is a regular platform driver, so LCD configuration
>> and board specific hooks are passed to the driver using platform data.
>> LCD modules using SYS interface often require special configuration
>> using the SYS bus, and to solve this cleanly the driver provides SYS
>> interface operations to the board code.
>>
>> Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
>> WVGA panels using RGB16 and RGB18 interfaces.
>>
>> ...
>>
>> +     while (lcdc_read(ch->lcdc, _LDSR) & 2)
>> +       ;
>
> Indenting is odd and inconsistent with most of the other zillions of
> busywait loops here (multiple instances)
>
> It might make sense to write a single function to do this busywaiting.
> That function can implement a timeout and can avoid lockups and provide
> useful diagnostics.

Breaking out to a single function and implementing timeout makes
sense. I'll see what I can do.

> Is sh's cpu_relax() a no-op?  Or are we assuming that ioread is a
> suitable substitute?

I simply forgot to use cpu_relax(). =)

I'll fix up the code and post a V2. Thank you for your review!

/ magnus
