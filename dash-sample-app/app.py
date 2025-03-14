from dash import Dash, html, dcc, callback, Output, Input
import plotly.express as px
import pandas as pd
import os

df = pd.read_csv('https://raw.githubusercontent.com/plotly/datasets/master/gapminder_unfiltered.csv')

url_base_pathname = os.environ.get("RENKU_BASE_URL_PATH") or "/"
if not url_base_pathname.endswith("/"):
    url_base_pathname = f"{url_base_pathname}/"

app = Dash(
    url_base_pathname=url_base_pathname,
)

# Requires Dash 2.17.0 or later
app.layout = [
    html.H1(children='Title of Dash App', style={'textAlign':'center'}),
    dcc.Dropdown(df.country.unique(), 'Canada', id='dropdown-selection'),
    dcc.Graph(id='graph-content')
]

@callback(
    Output('graph-content', 'figure'),
    Input('dropdown-selection', 'value')
)
def update_graph(value):
    dff = df[df.country==value]
    return px.line(dff, x='year', y='pop')

if __name__ == '__main__':
    print(f"url_base_pathname={app.config.url_base_pathname}")
    app.run(host="0.0.0.0", port=8050)
