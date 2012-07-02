From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Mon, 02 Jul 2012 10:19:40 +0000
Subject: Re: [PATCH/RFC] ARM: mach-shmobile: enable power switching on SDHI0 and SDHI2 on kzm9g
Message-Id: <4FF175BC.10804@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207010101280.24651@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207010101280.24651@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello, Guennadi

(2012/07/02 16:07), Guennadi Liakhovetski wrote:

>> I guess something missing. Please tell me how to test this patch
>> so that I will try again.
>
> Thanks for testing. Yes, these ARM patches are preparatory, they cannot
> work without respective counterparts in the mmc driver subsystem. At the
> very least you also need these patches:
>
> http://www.spinics.net/lists/linux-sh/msg12007.html
> http://www.spinics.net/lists/linux-sh/msg12160.html
>
> but at least the latter of them might not apply cleanly to your tree. It
> might be easier to test if you pull in the mmc-next branch of
>
> git://git.kernel.org/pub/scm/linux/kernel/git/cjb/mmc.git
>

Thanks.
Hmm, I'm afraid it takes long time for me to prepare proper tree.
I will try again when these dependencies merged, as you said
this patch is not urgent.

