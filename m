From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Date: Tue, 21 Apr 2009 07:17:32 +0000
Subject: Re: [PATCH][RFC] sh: suspend interpreter V1
Message-Id: <49ED730C.9050507@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090323091739.25647.6773.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus
> Can you disable power to certain parts of the SoC? Do you have
> multiple power domains?
>   
Not currently... It should be in the future.
But hibernation on memory works with a 'power domain' board based 
therefore it's easy to implement in the customer board.
> Do you need functions for saving and restoring hardware state in
> device drivers?
For some IP it's required.
>  I've been talking a bit about run time device power
> management. Maybe that would be useful for you guys?
>   
What do you have in mind?
Currently we release a kernel tool to leave the customer able to design 
their our power profile.
This means the system is moved from a profile to an other....

A real runtime power management requires a support linux currently 
doesn't have.

Regards
 Francesco
> Cheers,
>
> / magnus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   

