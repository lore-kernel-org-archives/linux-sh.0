From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 09:39:53 +0000
Subject: Re: [git pull] pinctrl: sh-pfc: Updates for v4.4
Message-Id: <CAMuHMdX09SXM2R8UEsLwD7fQ+vMjk_Y1rE+eRC8iwyhVoXUrsw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1443774347-383-1-git-send-email-geert+renesas@glider.be>
	<CACRpkdbDE8M=ri2NYjJc7s-MzHyv5ZHobNVk7izH2XYvWCVTeA@mail.gmail.com>
In-Reply-To: <CACRpkdbDE8M=ri2NYjJc7s-MzHyv5ZHobNVk7izH2XYvWCVTeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Linus,

On Fri, Oct 2, 2015 at 11:26 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Oct 2, 2015 at 1:25 AM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
>>
>>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git sh-pfc-for-v4.4
>>
>> for you to fetch changes up to 819fd4bfcc84805c48291de511c917596e911ffa:
>>
>>   pinctrl: sh-pfc: r8a7795: add EtherAVB support (2015-10-02 09:54:41 +0200)
>>
>> Summary:
>>   - Two fixes for incorrect pinmux data,
>>   - Initial r8a7795 (R-Car H3) support (incl. serial, I2C, audio,
>>     Ethernet),
>>   - Various cleanups.
>>
>> Most have been acked by Laurent and/or by you.
>
> Awesome, pulled into the pinctrl "devel" branch, will push to the kernel zeroday
> builder soon.

Thank you.

BTW, the zeroday builder consumed all of it earlier this week, but I had to
rebase to drop a few commits as per feedback from Laurent.

> If you have more stuff and fixes coming just send more pull requests
> based on this
> or my "devel" branch.

Good to know. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
