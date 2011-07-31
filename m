From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 31 Jul 2011 17:46:06 +0000
Subject: [PATCH 0/9] PM / Domains: Allow generic PM domains to have multiple parents
Message-Id: <201107311946.06654.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi,

This patchset modifies the generic PM domains code so that it's possible
for a PM domain to have multiple parent domains (i.e. domains it depends on).
This makes the framework applicable to more use cases and allows us to
address one issue one a system already using it.

Patch [1/9] is for 3.1, patches [2-9/9] are 3.2 material, if there are no
objections.

[1/9] - Fix genpd_power_on().
[2/9] - Make subdomain counts be atomic.
[3/9] - Don't acquire parent locks in genpd_power_on() and genpd_power_off().
[4/9] - Make genpd_power_on() always survive parent removal.
[5/9] - Add PM domain status value GPD_STATE_WAIT_PARENT.
[6/9] - Allow generic PM domains to have multiple parents.
[7/9] - Rename GPD_STATE_WAIT_PARENT to GPD_STATE_WAIT_MASTER.
[8/9] - Rename the second argument of pm_genpd_add_subdomain().
[9/9] - Make A3RV be a subdomain of A4LC on SH7372.

Thanks,
Rafael
