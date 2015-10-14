From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Oct 2015 07:12:26 +0000
Subject: Re: renesas-drivers-2015-10-13-v4.3-rc5
Message-Id: <CAMuHMdUPjA2TKBjN=X_Kgft0G+iG1yhdSsXB3PMmBODwYhQYDw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444732125-12741-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444732125-12741-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Oct 14, 2015 at 9:09 AM, Simon Horman <horms@verge.net.au> wrote:
>> >>     However, in the light of "[PATCH/RFC v3 0/3] clk: shmobile: Add new
>> >>     Renesas CPG/MSSR DT bindings"
>> >>     (http://www.spinics.net/lists/devicetree/msg97237.html), all of the
>> >>     above are temporary solutions.
>> >
>> > I would like to update topic/arm64-rcar-gen3-v10.1 and post
>> > as v11 for further review both here and in the broader Linux ARM community
>> > at linux-arm-kernel@lists.infradead.org.
>> >
>> > Do you recommend updating that patchset for the above? If so in
>> > which way do you recommend updating it?
>>
>> I'm afraid there's not much you can do before I have a new CPG/MSSR
>> driver that works.
>>
>> You can start updating the dtsi, but you can't test it, and I had to do the same
>> updates to test my driver anyway.
>
> My motivation for posting v11 is to get more eyes on the code.
> I think its fine to state that the CPG bindings are expected to
> change. With that in mind I think it would be best not to make any changes
> to topic/arm64-rcar-gen3-v10.1 in that regard for v11. Does that sound
> sensible?

Yes, that's fine. Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
