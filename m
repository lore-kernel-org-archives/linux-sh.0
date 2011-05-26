From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Thu, 26 May 2011 06:31:37 +0000
Subject: Re: [PATCH 0/6 v2] MERAM support for LCDC
Message-Id: <alpine.DEB.2.00.1105261502320.31722@localhost6.localdomain6>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="269091478-1312783175-1306391508=:31722"
List-Id: <linux-sh.vger.kernel.org>
References: <1305717011-20742-1-git-send-email-dhobsong@igel.co.jp>
In-Reply-To: <1305717011-20742-1-git-send-email-dhobsong@igel.co.jp>
To: linux-sh@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--269091478-1312783175-1306391508=:31722
Content-Type: TEXT/PLAIN; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi Magnus,

On Thu, 26 May 2011, Magnus Damm wrote:

> Hi Damian,
>
> On Tue, May 24, 2011 at 11:53 AM, Damian Hobson-Garcia
> <dhobsong@igel.co.jp> wrote:
>> Hi Paul,
>>
>> On 2011/05/23 15:51, Paul Mundt wrote:
>>> On Wed, May 18, 2011 at 08:10:05PM +0900, Damian Hobson-Garcia wrote:
>>>>
>>>> Damian Hobson-Garcia (6):
>>>> =A0 sh_mobile: Add MSTP clock for MERAM
>>>> =A0 sh_mobile_meram: MERAM framework for LCDC
>>>> =A0 sh_mobile_meram: Add support for NV24 framebuffers
>>>
>>> These basically seem to be fine, and make up for the bulk of the new
>>> code, so I'll take them as-is. I'll let you and Magnus hash out the
>>> remaining bits after this.
>>
>> Ok great, thanks a lot. I'll submit any further patches to apply on top
>> of these three.
>
> The LCDC driver does no longer compile:
>
> linux-2.6 git 14d74e0cab7a7779a7ff0c3863c04c8a8e507106
>
>  CC      drivers/video/sh_mobile_meram.o
>  CC      drivers/video/sh_mobile_lcdcfb.o
> drivers/video/sh_mobile_lcdcfb.c: In function 'sh_mobile_lcdc_start':
> drivers/video/sh_mobile_lcdcfb.c:640:4: error: 'ret' undeclared (first
> use in this function)
> drivers/video/sh_mobile_lcdcfb.c:640:4: note: each undeclared
> identifier is reported only once for each function it appears in
> make[2]: *** [drivers/video/sh_mobile_lcdcfb.o] Error 1
> make[1]: *** [drivers/video] Error 2
> make: *** [drivers] Error 2
>
> I suspect this change may be related to the MERAM patch, but I'm not sure.
>
> Can you please have a look?

It seems that when this patch

69843ba7f24950f8ef5dadacfbfbd08f53e3455b
fbdev: sh_mobile_lcdc: reduce scope of a variable

and the meram stuff was merged together there was a problem.

The definition of ret got stashed away into an if-clause, making it
unavaliable for the call on line 640 that the compiler complains about.

I'll submit another pactch to the list that will resolve the conflict, but
as it looks like a merge issue, I don't know how exactly that should be=20
dealt with.

Thanks,
Damian
--269091478-1312783175-1306391508=:31722--
