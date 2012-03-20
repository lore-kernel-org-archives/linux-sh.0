From: Kevin Hilman <khilman@ti.com>
Date: Tue, 20 Mar 2012 23:56:51 +0000
Subject: Re: [PATCH v8 0/8] Consolidate cpuidle functionality
Message-Id: <87ty1ix1vg.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1332274969-15782-1-git-send-email-rob.lee@linaro.org>
 <201203202158.08042.arnd.bergmann@linaro.org> <873992zy5u.fsf@ti.com>
 <201203202305.37952.arnd.bergmann@linaro.org>
In-Reply-To: <201203202305.37952.arnd.bergmann@linaro.org> (Arnd Bergmann's
 message of "Tue, 20 Mar 2012 23:05:37 +0000")
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Arnd Bergmann <arnd.bergmann@linaro.org> writes:

> On Tuesday 20 March 2012, Kevin Hilman wrote:
>> Maybe it's time that drivers/cpuidle gets a maintainer.  With lots of
>> discussions of scheduler changes that affect load estimation, I suspect
>> we're all going to have a bit of CPUidle work to do in the
>> not-so-distant future.
>
> Hmm, according to the script, you are the maintainer ;-)

doh, I knew I should've kept quiet :/

> $ scripts/get_maintainer.pl -f drivers/cpuidle/cpuidle.c
> Kevin Hilman <khilman@ti.com> (commit_signer:8/10=80%)
> Len Brown <len.brown@intel.com> (commit_signer:7/10p%)
> Trinabh Gupta <g.trinabh@gmail.com> (commit_signer:4/10@%)
> Arjan van de Ven <arjan@linux.intel.com> (commit_signer:4/10@%)
> Deepthi Dharwar <deepthi@linux.vnet.ibm.com> (commit_signer:4/10@%)
>
> While I realize that the get_maintainers.pl is not the final word,
> you could be the acting cpuidle maintainer for this merge window
> and send the pull request.

Not exactly the outcome I was hoping for (I have enough stuff to look
after at the moment.)=20

However, if you think it would help and won't be seen as a take over
attempt (I don't want to maintain CPUidle), I can possibly do it for
this merge window. =20

Before doing that though, I'll need give this series a final once over
before I'm willing to send a potentially flame-attracting pull request.

Kevin


