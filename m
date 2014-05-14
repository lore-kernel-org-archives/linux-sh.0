From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 14 May 2014 02:33:08 +0000
Subject: Re: [PATCH] ASoC: rsnd: Fix warnings due to improper printk formats
Message-Id: <5372D5E4.9060300@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399936220-17123-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <871tvysge5.wl%kuninori.morimoto.gx@renesas.com> <20140513213935.GA6784@verge.net.au>
In-Reply-To: <20140513213935.GA6784@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org

Hi

>>> Use the %pap printk specifier to print resource_size_t variables. This
>>> fixes warnings on platforms where resource_size_t has a different size
>>> than int.
>>>
>>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>> ---
>>
>> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Morimoto-san, should Mark Brown need to be CCed on a re-post
> in order for him to see this?

Ahh, I didn't notice that Mark wasn't CCed.
He never (?) accepts patch which doesn't have "To" him.

Please use this address,
broonie@kernel.org

