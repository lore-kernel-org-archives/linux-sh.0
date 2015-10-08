From: David Miller <davem@davemloft.net>
Date: Thu, 08 Oct 2015 11:54:37 +0000
Subject: Re: [PATCH v2 0/4] sh_eth: Remove obsolete platform_device_id entries
Message-Id: <20151008.051023.991121515814557831.davem@davemloft.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1444205657-25314-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444205657-25314-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert+renesas@glider.be
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed,  7 Oct 2015 10:14:13 +0200

> Since commit 3d7608e4c169af03 ("ARM: shmobile: bockw: remove legacy
> board file and config"), which is now in arm-soc/for-next, shmobile SoCs
> are only supported in generic DT-only ARM multi-platform builds.
> The sh_eth driver doesn't need to match platform devices by name
> anymore, hence this series removes the corresponding platform_device_id
> entries.
> 
> Changes since v1:
>   - Protect some data and functions by #ifdef CONFIG_OF to silence
>     unused compiler warnings on SH,
>   - New patches 3 and 4.

Since that commit isn't in any of my trees why don't you merge this
via arm-soc/for-next?

Thanks.
