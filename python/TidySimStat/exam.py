

from TidySimStat.auxiliary import *
from TidySimStat.inference import *


def exam_sim_drv(f_sim, p:list=[7/16, 1/4, 1/8, 3/16], num_sim:int=10000):
    """Examine simulators for discrete random variables

    Keyword Arguments
    =================
    f_sim: functions to simulate
    """
    if not callable(f_sim):
        raise Exception("Input `f_sim` is not a function!")

    n = len(p)

    xs = [f_sim(p) for l in range(num_sim)]
    p_sample = [xs.count(l) / num_sim for l in range(1, n+1)]

    ## KS test
    li_count = [xs.count(l) for l in range(1, n+1)]
    li_cdf = pmf2cdf(p)
    # stat = cal_stat_gof(li_count, li_cdf)
    # pvalue = cal_pvalue_chi2(stat, df=5)
    test_dist(pvalue)

    ## Start plotting.
    labels = [l for l in range(1, n+1)]

    x = np.arange(len(labels))  # the label locations
    width = 0.35  # the width of the bars

    fig, ax = plt.subplots()
    rects1 = ax.bar(x - width/2, p, width, label='given')
    rects2 = ax.bar(x + width/2, p_sample, width, label='sample')

    # Add some text for labels, title and custom x-axis tick labels, etc.
    ax.set_ylabel('Probability')
    ax.set_title('Given Probabilities and Probabilities from Samples')
    ax.set_xticks(x)
    ax.set_xticklabels(labels)
    ax.legend()


    def autolabel(rects):
        """Attach a text label above each bar in *rects*, displaying its height."""
        for rect in rects:
            height = rect.get_height()
            ax.annotate('{}'.format(height),
                xy=(rect.get_x() + rect.get_width() / 2, height),
                xytext=(0, 3),  # 3 points vertical offset
                textcoords="offset points",
                ha='center', va='bottom')


    autolabel(rects1)
    autolabel(rects2)

    fig.tight_layout()

    plt.show()
