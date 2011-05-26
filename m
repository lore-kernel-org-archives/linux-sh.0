From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 26 May 2011 04:10:32 +0000
Subject: Re: [PATCH 0/6 v2] MERAM support for LCDC
Message-Id: <BANLkTikTkoGf=Jh7LDt+4mEHCPaRkFJJBw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1305717011-20742-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1305717011-20742-1-git-send-email-dhobsong@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Damian,

On Tue, May 24, 2011 at 11:53 AM, Damian Hobson-Garcia
<dhobsong@igel.co.jp> wrote:
> Hi Paul,
>
> On 2011/05/23 15:51, Paul Mundt wrote:
>> On Wed, May 18, 2011 at 08:10:05PM +0900, Damian Hobson-Garcia wrote:
>>> This patch series adds support for read-ahead cache-access from the
>>> LCDC to the main memory. =A0These patches enabled the LCDC to access
>>> the MERAM memory via ICB. =A0The specific ICBs to use are chip dependent
>>> and defined in the platform data.
>>>
>>> The MERAM clock will enable when the LCDC clocks do, and are allowed to
>>> be disbled when the LCDC clocks are.
>>>
>>> Changes from V1
>>> ---------------
>>> * Specified meram info data (struct sh_mobile_meram_info *meram_dev) as
>>> =A0 part of the LCDC device data, not the LCDC channel data, since the =
info
>>> =A0 data corresponds to the whole device, not just one configuration.
>>>
>>> * Added dynamic clock enable/disable via runtime_pm.
>>>
>>> * Changed .id from -1 to 0 in platform data
>>>
>>> Damian Hobson-Garcia (6):
>>> =A0 sh_mobile: Add MSTP clock for MERAM
>>> =A0 sh_mobile_meram: MERAM framework for LCDC
>>> =A0 sh_mobile_meram: Add support for NV24 framebuffers
>>
>> These basically seem to be fine, and make up for the bulk of the new
>> code, so I'll take them as-is. I'll let you and Magnus hash out the
>> remaining bits after this.
>
> Ok great, thanks a lot. I'll submit any further patches to apply on top
> of these three.

The LCDC driver does no longer compile:

linux-2.6 git 14d74e0cab7a7779a7ff0c3863c04c8a8e507106

  CC      drivers/video/sh_mobile_meram.o
  CC      drivers/video/sh_mobile_lcdcfb.o
drivers/video/sh_mobile_lcdcfb.c: In function 'sh_mobile_lcdc_start':
drivers/video/sh_mobile_lcdcfb.c:640:4: error: 'ret' undeclared (first
use in this function)
drivers/video/sh_mobile_lcdcfb.c:640:4: note: each undeclared
identifier is reported only once for each function it appears in
make[2]: *** [drivers/video/sh_mobile_lcdcfb.o] Error 1
make[1]: *** [drivers/video] Error 2
make: *** [drivers] Error 2

I suspect this change may be related to the MERAM patch, but I'm not sure.

Can you please have a look?

Thanks,

/ magnus
