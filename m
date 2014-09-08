From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date: Mon, 08 Sep 2014 22:47:55 +0000
Subject: Re: [PATCH 00/15] PM / Domains: Cleanups and remove superfluous APIs
Message-Id: <2208348.uMLR68bVng@vostro.rjw.lan>
List-Id: <linux-sh.vger.kernel.org>
References: <1409741551-16437-1-git-send-email-ulf.hansson@linaro.org>
 <7ha96eyt9f.fsf@paris.lan>
In-Reply-To: <7ha96eyt9f.fsf@paris.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday, September 05, 2014 08:35:56 AM Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > This patchset has a bit of a history and some parts of it has been posted
> > earlier.
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262725.html
> >
> > The intent is to simplify code for the generic power domain and also some of
> > the machine specific code that uses the generic power domain.
> >
> > Do note, there are dependencies through this patchset, especially related to
> > the ARM SoC changes, thus they all need to be kept together.
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>

My understanding is that this is for the whole series.

Which I'm queuing up for 3.18, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
