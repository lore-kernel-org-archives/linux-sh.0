From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 17 Jun 2010 23:59:17 +0000
Subject: Re: [PATCH v3 1/4] Add the directory mach-sh2007 for SH-2007 board
Message-Id: <AANLkTikO8c43gnUHV2U3OBThIiPrJdb0PqzQWqCYsZo8@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1276231892-22850-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
In-Reply-To: <1276231892-22850-2-git-send-email-mitake@dcl.info.waseda.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Thu, Jun 17, 2010 at 6:14 PM, Hitoshi Mitake
<mitake@dcl.info.waseda.ac.jp> wrote:
> On 06/11/10 13:51, Hitoshi Mitake wrote:
>> This patch adds directory for SH-2007 support and modify tools/mach-type=
s.
>> mach-sh2007/setup.c ... Setup platform devices and provide machine vecto=
r.
>> tools/mach-types ... Added entry of SH2007 for mach_is_sh2007()
>>
>> CAUTION: IDE support is not tested yet.
>> =A0 =A0 =A0 =A0I'll be able to obtain cable for 2.5 inch HDD,
>> =A0 =A0 =A0 =A0then I'll test this device.
>
> Sadly, my plan to obtain the cable for 2.5 inch HDD is failed.
> I cannot predict when I can test IDE support of SH-2007.
>
> Should I remove IDE support?

That's what I would do. But it's up to you!

/ magnus
