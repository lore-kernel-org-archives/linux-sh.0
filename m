From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Dec 2013 15:18:11 +0000
Subject: Re: [PATCH v6 15.1/17] ARM: shmobile: Add GPIO keys to Koelsch DTS
Message-Id: <CAMuHMdVqo2Zu0E63Q2ysEd56uWOE4nH1U5-+E_xw2g9xHGDw0Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387466923-8800-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 20, 2013 at 3:40 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> I've seen that when implementing the original Koelsh GPIO keys DT support and
>> poundered how to handle it properly. It basically boils down the how we define
>> a GPIO key. A GPIO is a hardware concept, but a key is defined by its usage
>> intent. As the buttons and DIP switches you refer to are just buttons and
>> switches without a defined purpose, how to handle them is I believe a policy
>> decision.

> Please note that in the Lager case we only have DIP switches, so
> waking up from Suspend-to-RAM via GPIO can only be done via the DIP
> switch. Because of that I prefer to allow wakeup via DIP switch in a
> consistent way for both Lager and Koelsch. Did you have any special
> idea how to interface to the DIP switches so we can wake up from
> Suspend-to-RAM? =)

Can't you handle the wakeup key mapping from the DT, as this is a usage
intent? E.g. through a board-specific alias, or through chosen.
Documentation/devicetree/bindings/input/input-reset.txt shows an example
through chosen.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
