From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 18 Jul 2013 12:26:17 +0000
Subject: Re: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <51E7DEE9.8060208@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 18-07-2013 10:35, Kuninori Morimoto wrote:

>> But is it really that much easier?
>> Does this series remove all the other unused code from setup.c?
>> Does it really matter if we forget to remove some bits of setup.c
>> once they are unused?

> The point is not "unused code", but "non-shared sharing code".
> I guess people use copy-paste base development.
> So, if we don't clean-up these "non-shared sharing code" now,
> we will have more and more r8a77xx_add_xxx_device(pdata) type method
> (which is the "non-shared sharing code" :)

    And that will teach them doing things the right, scalable way from the start.

> in both board-xxx.c and setup-xxx.c before we have DT support.
> This means clean-up these "after" DT support will be more complex.
> I don't want this type of nightmare.

    And I don't want "SoC device in the board code" non-scalable nightmare
when people will start producing their own boards based on Renesas SoCs. I 
don't want to give them the bad example that your USB code was before my 
9-patch cleanup, and another several bad examples which you're now to trying 
to push into renesas.git. I don't want my efforts wasted.

> Do you mean r8a7779 sh_eth clean-up code ?
> If so, 1) I can't find "board" code which is using r8a7779_add_ether_device(xx),
> 2) I guess marzen board doesn't have sh_eth HW implementation.

    It has several types of daughter boards with Ethernet PHY and connector. 
See my off-list email.

> Best regards
> ---
> Kuninori Morimoto

WBR, Sergei

