From: Brian Norris <computersforpeace@gmail.com>
Date: Fri, 08 May 2015 18:47:54 +0000
Subject: Re: [PATCH] ARM: tegra: add "nor-jedec" flash compatible binding
Message-Id: <20150508184754.GA32500@ld-irv-0074>
List-Id: <linux-sh.vger.kernel.org>
References: <1431066098-19821-1-git-send-email-zajec5@gmail.com>
 <554CDD8C.7050000@wwwdotorg.org>
 <20150508184317.GZ32500@ld-irv-0074>
In-Reply-To: <20150508184317.GZ32500@ld-irv-0074>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 08, 2015 at 11:43:17AM -0700, Brian Norris wrote:
> I'm open to change, as this binding is new in 4.1-rc1.

Though we'd need to make sure any change to "nor-jedec" gets applied to
the shmobile platforms that have started using this string in
linux-next.

Brian
