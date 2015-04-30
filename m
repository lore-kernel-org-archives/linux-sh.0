From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 30 Apr 2015 14:18:30 +0000
Subject: Re: [PATCH 04/11] ARM: shmobile: r8a7793: add Gose board device tree
Message-Id: <CAO3366wCcVnsosw3PkY5ZSRgP_GV_XPwb21CQoTMYUyOh19e8w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Mar 8, 2015 at 11:04 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>> DT description and Makefile entry for the Gose eval board.
>
> Thanks!
>
> Same comment here as for r8a7791.dtsi.
> Please start from current r8a7791-koelsch.dts. You'll find more small
> things that
> need to fixed.

Yes, this one was a bit dodgier than the dtsi file...

I dropped adv7511 because Gose board docs are secret and I don't want
to guess the address.

CU
Uli
