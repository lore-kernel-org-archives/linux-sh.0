From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Sep 2015 00:45:45 +0000
Subject: Re: [PATCH 0/6] arm64: renesas: Obtain MD pin values using syscon/regmap
Message-Id: <20150911004545.GB11622@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441120361-1232-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441120361-1232-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 02, 2015 at 11:30:16AM +0200, Geert Uytterhoeven wrote:
> On Tue, Sep 1, 2015 at 5:12 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > This patch series converts the R-Car Gen3 Clock Pulse Generator (CPG)
> > driver from obtaining the mode pin values using mapping of the hardcoded
> > MODEMR register to using syscon and regmap.
> >
> > It follows the same spirit as "[PATCH/RFC 00/11] ARM: shmobile: Let CPG
> > use syscon for MD pin values"[*], but this time I did write DT binding
> > documentation.
> >
> > Feel free to fold some patches into the r8a7795 cpg, dtsi, and Kconfig
> > baseline.
> 
> Imported into topic/gen3-modemr-syscon-v1

Hi Geert,

I'm wondering how you feel we could move the driver portions of
this changeset forwards. I see some discussion of the reset patch,
though its not clear to me how that might conclude. And no discussion so
far on the clk patches. Let me know if I can help in any way.
