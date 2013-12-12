From: Geoff Levand <geoff@infradead.org>
Date: Thu, 12 Dec 2013 19:30:01 +0000
Subject: Re: [PATCH 4/4] sh/kexec: Fix kexec build warning
Message-Id: <1386876601.1002.0.camel@smoke>
List-Id: <linux-sh.vger.kernel.org>
References: <594a3d26aac66e9668edc81d7bfb4e801575514f.1386807069.git.geoff@infradead.org>
In-Reply-To: <594a3d26aac66e9668edc81d7bfb4e801575514f.1386807069.git.geoff@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Thu, 2013-12-12 at 15:48 +0100, Geert Uytterhoeven wrote:
> On Thu, Dec 12, 2013 at 1:18 AM, Geoff Levand <geoff@infradead.org> wrote:
> > -                                    image->segment[i].memsz,
> > +                      (unsigned int)image->segment[i].memsz,e->start);
> 
> Wouldn't it be better to remove all casts and correct the printf-style
> format specifiers instead?

That would be better, I'll make a new patch.

Thanks Geert!


