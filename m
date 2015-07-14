From: Tejun Heo <tj@kernel.org>
Date: Tue, 14 Jul 2015 21:39:41 +0000
Subject: Re: [PATCH] ata: sata_rcar: Remove obsolete sata-r8a779* platform_device_id entries
Message-Id: <20150714213941.GF2273@mtj.duckdns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064113-10742-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064113-10742-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-ide@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Jun 23, 2015 at 02:55:13PM +0200, Geert Uytterhoeven wrote:
> Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
> board support"), R-Car Gen2 SoCs are only supported in generic DT-only
> ARM multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to libata/for-4.3.

Thanks.

-- 
tejun
