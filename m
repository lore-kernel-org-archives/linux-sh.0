From: Arnd Bergmann <arnd.bergmann@linaro.org>
Date: Tue, 20 Mar 2012 23:05:37 +0000
Subject: Re: [PATCH v8 0/8] Consolidate cpuidle functionality
Message-Id: <201203202305.37952.arnd.bergmann@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <201203202158.08042.arnd.bergmann@linaro.org> <873992zy5u.fsf@ti.com>
In-Reply-To: <873992zy5u.fsf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Tuesday 20 March 2012, Kevin Hilman wrote:
> Maybe it's time that drivers/cpuidle gets a maintainer.  With lots of
> discussions of scheduler changes that affect load estimation, I suspect
> we're all going to have a bit of CPUidle work to do in the
> not-so-distant future.

Hmm, according to the script, you are the maintainer ;-)

$ scripts/get_maintainer.pl -f drivers/cpuidle/cpuidle.c
Kevin Hilman <khilman@ti.com> (commit_signer:8/10=80%)
Len Brown <len.brown@intel.com> (commit_signer:7/10p%)
Trinabh Gupta <g.trinabh@gmail.com> (commit_signer:4/10@%)
Arjan van de Ven <arjan@linux.intel.com> (commit_signer:4/10@%)
Deepthi Dharwar <deepthi@linux.vnet.ibm.com> (commit_signer:4/10@%)

While I realize that the get_maintainers.pl is not the final word,
you could be the acting cpuidle maintainer for this merge window
and send the pull request.

	Arnd
