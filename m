From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Fri, 17 Apr 2009 12:00:22 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <49E86F56.8020006@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
> For boot loader, do you use upstream U-boot? That would be interesting to see.
>   
We are moving on an internal light boot-loader.
> Apart from that, this approach is low on my list. This because it
> affects a lot of code and it may be difficult to maintain. I want to
> prioritize R-standby where we can power off most of the CPU but still
> resume from RAM without boot loader modifications...
This means the main CPU core is still powered. Is it?
While in the hibernation on memory the CPU runs from a standard power-on.
>  Do you have a mode similar to R-standby?
>   
No we haven't.
Regards
 Francesco
