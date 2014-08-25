From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 25 Aug 2014 09:59:12 +0000
Subject: Re: [PATCH 01/10 v2 resend] mmc: block: add block number limitation flag for multiple block read
Message-Id: <87tx50sxe9.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
	<8761hk7wgy.wl%kuninori.morimoto.gx@gmail.com>
	<874mx47wf9.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFqwDTBu53t6iiiA6REe3feBFWWmgd-V93RsOh5XFPpc4w@mail.gmail.com>
	<87fvgltmnn.wl%kuninori.morimoto.gx@gmail.com>
	<CAPDyKFqkstphRrj_0EFx52Snboaz8NryxXkFgY8Zb-CLeGhMZw@mail.gmail.com>
In-Reply-To: <CAPDyKFqkstphRrj_0EFx52Snboaz8NryxXkFgY8Zb-CLeGhMZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Ulf

Thank you for your feedback

> > If you can't accept it, we will consider it again.
> > But is it possilbe to keep consistency if host side exchange block size
> > without using framework ??
> 
> Nope, we need adaptations to the framework and I have no objections to that.

Thank you.
Basically, I agree with your opinion (= it locals to host driver side, not on framework)
but, I couldn't find good method for it
(the size is decided on framework, and it seems host side driver can't do something to it)
And, we noticed similar flag.
But, hmm... if we can have callback function on framework...

/*
 * this can replace MMC_CAP2_NO_MULTI_READ ?
 */
void no_multi_read_fixup(struct mmc_blk_request *brq,
                         struct request *req)
{
        if (rq_data_dir(req) = READ)
             brq->data.blocks = 1;
}

/*
 * we can use this instead of MMC_CAP2_2BLKS_LIMIT ?
 */
void two_block_limit_read_fixup(struct mmc_blk_request *brq,
                                struct request *req)
{
        if ((rq_data_dir(req) = READ) && 
            (brq->data.blocks = 2))
                brq->data.blocks = 1;
}

static void mmc_blk_rw_rq_prep(xxxx)
{
        ...
        if (brq->data.blocks > 1) {
              ...

              if (card->host->host_data_fixup)
                     card->host->host_data_fixup(brq, req)
        }
        ...
}

> > Because this method will check caps2 flag twice for
> > MMC_CAP2_2BLKS_LIMIT and MMC_CAP2_NO_MULTI_READ in such case.
> > But, these are similar flag, and is no effect for almost all drivers.
> > We avoided such checks.
> 
> I see, but I don't think such "optimization" is worth much. To me it
> just adds a bit of confusion. I would prefer to have them separate.

OK, I see.
I already posted v3 patch-set which doesn't have this patch.
I will post v3 of this patch if above v3 patch-set were accepted.

Best regards
---
Kuninori Morimoto
