From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 17 Dec 2009 17:50:07 +0000
Subject: Re: [PATCH 2/3 v2] sh: fix DMA driver's descriptor chaining and
Message-Id: <e9c3a7c20912170950g755f8774i768d3c9502a0f601@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912101826010.4487@axis700.grange>
	 <Pine.LNX.4.64.0912101833170.4487@axis700.grange>
	 <20091211080254.GB7625@linux-sh.org>
	 <29ab51dc0912111815s2095539cjc3d0450435725452@mail.gmail.com>
	 <29ab51dc0912161909r7a6e5397sc751a49a636d755d@mail.gmail.com>
	 <Pine.LNX.4.64.0912170831430.5991@axis700.grange>
	 <29ab51dc0912170033s4185153emc1aaafdc83607532@mail.gmail.com>
	 <Pine.LNX.4.64.0912170940470.5991@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912170940470.5991@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Dec 17, 2009 at 1:43 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Sure, I never assumed the opposite, that's why I said "you forgot." Same
> thing happened to me too recently, fortunately, I noticed it early enough
> to push a correct version. The actual problem with your version was
> white-space changes.

I kept your original v2 patch.  You can double check the state of my
'fixes' branch [1].

Thanks,
Dan

[1]: http://git.kernel.org/?p=linux/kernel/git/djbw/async_tx.git;a=shortlog;h=refs/heads/fixes
