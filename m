From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Mon, 22 Jun 2015 23:41:04 +0000
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Message-Id: <5913118.ZpKlm0JFgd@vostro.rjw.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday, June 22, 2015 09:31:22 AM Geert Uytterhoeven wrote:
> If pm_genpd_{add,remove}_device() keeps on failing with -EAGAIN, we end
> up with an infinite loop in genpd_dev_pm_{at,de}tach().
> 
> This may happen due to a genpd.prepared_count imbalance.  This is a bug
> elsewhere, but it will result in a system lock up, possibly during
> reboot of an otherwise functioning system.
> 
> To avoid this, put a limit on the maximum number of loop iterations,
> including a simple back-off mechanism.  If the limit is reached, the
> operation will just fail.  An error message is already printed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This was too late for my first 4.2 pull request, but I may push it in the
second half of the merge window.  Does it depend on anything?

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
