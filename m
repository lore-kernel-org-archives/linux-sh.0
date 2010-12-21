From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 21 Dec 2010 01:32:13 +0000
Subject: Re: about ap4evb HDMI video
Message-Id: <w3psjxroqqq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pbp4g6enp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pbp4g6enp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Guennadi, Magnus

> Please let us know what the differences are. If you have a config option
> enabled that causes an -ENOMEM then we need to know what that is, and
> what is causing it.

I checked diff my.config guennadi.config
The critical config was

CONFIG_FORCE_MAX_ZONEORDER

guennadi's config was 12
my         config was 11

default value seems 11 ?

Best regards
--
Kuninori Morimoto
 
