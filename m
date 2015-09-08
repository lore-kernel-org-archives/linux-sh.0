From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2015 19:06:53 +0000
Subject: Re: [PATCH v2] staging: board: Migrate away from __pm_genpd_name_add_device()
Message-Id: <20150908190653.GA10156@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1441731963-18271-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441731963-18271-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devel@driverdev.osuosl.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Kevin Hilman <khilman@kernel.org>

On Tue, Sep 08, 2015 at 07:06:03PM +0200, Geert Uytterhoeven wrote:
> The named genpd APIs are deprecated. Hence convert the board staging
> code from using genpd names to DT node paths.
> 
> For now this supports PM domains with "#power-domain-cells = <0>" only.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> Rafael, Greg: If Greg provides his Acked-by, Rafael can apply this patch
> to the linux-pm tree as a prerequisite for Ulf's patches to remove the
> named genpd APIs.
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
