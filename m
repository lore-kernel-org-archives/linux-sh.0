From: Rich Felker <dalias@libc.org>
Date: Sun, 12 Jul 2020 23:39:48 +0000
Subject: Re: [PATCH] sh: Replace HTTP links with HTTPS ones
Message-Id: <20200712233944.GB14669@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <8b008a69-e73a-43cc-3dba-c1bce90c9902@landley.net>
 <20200712111118.24916-1-grandmaster@al2klimov.de>
 <14fdab51-0197-1784-9ebb-356a0fd39952@landley.net>
In-Reply-To: <14fdab51-0197-1784-9ebb-356a0fd39952@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 06:30:04AM -0500, Rob Landley wrote:
> On 7/12/20 6:11 AM, Alexander A. Klimov wrote:
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
> 
> Trimmed just to the one site without the self-signed certficate: check.
> 
> > Deterministic algorithm:
> > For each file:
> >   If not .svg:
> >     For each line:
> >       If doesn't contain `\bxmlns\b`:
> >         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> >             If both the HTTP and HTTPS versions
> >             return 200 OK and serve the same content:
> >               Replace HTTP with HTTPS.
> > 
> > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> 
> Acked-by: Rob Landley <rob@landley.net>

Acked-by: Rich Felker <dalias@libc.org>

I agree about replacing just the one with working https, not the dead
self-signed one. Alexander, is this whole set being submitted upstream
through a single maintainer, or do you want me to take the arch/sh
patch individually?

Rich
